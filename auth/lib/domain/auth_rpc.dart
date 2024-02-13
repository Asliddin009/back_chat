import 'dart:developer';
import 'dart:isolate';

import 'package:auth/data/role/role.dart';
import 'package:auth/data/user/user.dart';
import 'package:auth/domain/repository.dart';
import 'package:auth/env.dart';
import 'package:auth/generated/auth_sms.pbgrpc.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:stormberry/stormberry.dart';
import 'package:username_generator/username_generator.dart';

import '../generated/auth.pbgrpc.dart';

class AuthRpc extends AuthRpcServiceBase {
  late final ClientChannel _channel;
  late final AuthSmsRpcClient _smsRpcClient;
  final IRepo repo;

  AuthRpc(this.repo, {bool isTest = false}) {
    if (isTest == false) {
      _channel = ClientChannel("auth_sms",
          port: Env.portSms,
          options: const ChannelOptions(
            credentials: ChannelCredentials.insecure(),
          ));
      _smsRpcClient = AuthSmsRpcClient(_channel);
    }
  }

  @override
  Future<ResponseDto> deleteUser(ServiceCall call, RequestDto request) async {
    final id = Utils.getIdFromMetadata(call);
    final user = await repo.feathUser(id);
    if (user == null) throw GrpcError.notFound("Пользователь не найден");

    repo.deleteUser(id);
    return ResponseDto(message: "Пользователь удален");
  }

  @override
  Future<UserDto> fetchUser(ServiceCall call, RequestDto request) async {
    final id = Utils.getIdFromMetadata(call);
    final user = await repo.feathUser(id);
    if (user == null) throw GrpcError.notFound("Пользователь не найден");
    return Utils.getUserDtoFromUserVeiw(user);
  }

  @override
  Future<TokensDto> refreshToken(ServiceCall call, TokensDto request) async {
    if (request.refreshToken.isEmpty) {
      throw GrpcError.invalidArgument('Email not found');
    }
    final id = Utils.getIdFromToken(request.refreshToken);
    final user = await repo.feathUser(id);
    if (user == null) throw GrpcError.notFound("User not found");
    return _createTokens(user.id.toString(), user.roleList);
  }

  @override
  Future<TokensDto> signIn(ServiceCall call, UserDto request) async {
    if (request.email.isEmpty) {
      throw GrpcError.invalidArgument('Email not found');
    }
    if (request.password.isEmpty) {
      throw GrpcError.invalidArgument('Password not found');
    }
    final hashPassword = Utils.getHastPassword(request.password);
    final users =
        await repo.feathUsers(QueryParams(where: "email='${request.email}'"));
    if (users.isEmpty) {
      throw GrpcError.notFound("Пользователей с таким mail не существует");
    }
    final user = users[0];
    if (hashPassword != user.password) {
      throw GrpcError.unauthenticated("Неправельный пароль");
    }
    return _createTokens(user.id.toString(), user.roleList);
  }

  @override
  Future<TokensDto> signUp(ServiceCall call, UserDto request) async {
    if (request.email.isEmpty) {
      throw GrpcError.invalidArgument('Email not found');
    }
    if (request.password.isEmpty) {
      throw GrpcError.invalidArgument('Password not found');
    }
    if (request.username.isEmpty) {
      throw GrpcError.invalidArgument('Username not found');
    }
    try {
      final id = await repo.addUser(UserInsertRequest(
        roleList: [3],
        username: request.username,
        email: request.email,
        password: Utils.getHastPassword(request.password),
      ));
      repo.addUserRole(id, roleId: 3);
      return _createTokens(id.toString(), [3]);
    } catch (error) {
      log('$error');
      throw GrpcError.notFound("Такой пользователь уже существует");
    }
  }

  @override
  Future<UserDto> updateUser(ServiceCall call, UserDto request) async {
    final id = Utils.getIdFromMetadata(call);
    repo.updateUser(UserUpdateRequest(
        id: id,
        username: request.username.isEmpty ? null : request.username,
        email: request.email.isEmpty ? null : request.email,
        password: request.password.isEmpty
            ? null
            : Utils.getHastPassword(request.password)));
    final user = await repo.feathUser(id);
    if (user == null) throw GrpcError.notFound("Что то пошло не так");
    return Utils.getUserDtoFromUserVeiw(user);
  }

  TokensDto _createTokens(String id, List<int> roleListId) {
    final roleId = Utils.convertListToString(roleListId);
    final accessTokenSet = JwtClaim(
        maxAge: Duration(hours: Env.accessTokenLife),
        otherClaims: {'user_id': id, 'role_id': roleId});
    final refreshTokenSet = JwtClaim(
        maxAge: Duration(hours: Env.refreshTokenLife),
        otherClaims: {'user_id': id, 'role_id': roleId});
    return TokensDto(
        accessToken: issueJwtHS256(accessTokenSet, Env.sk),
        refreshToken: issueJwtHS256(refreshTokenSet, Env.sk));
  }

  @override
  Future<ListUserDto> findUser(ServiceCall call, FindDto request) async {
    final offset = int.tryParse(request.offset) ?? 0;
    final limit = int.tryParse(request.limit) ?? 100;
    final key = request.key;
    if (key.isEmpty) return ListUserDto(users: []);
    final query = "username LIKE '%$key%'";
    final listUsers = await repo.feathUsers(QueryParams(
        limit: limit, offset: offset, orderBy: 'username', where: query));
    return await Isolate.run(() => Utils.parseUsers(listUsers));
  }

  @override
  Future<ResponseDto> signInSms(ServiceCall call, UserDto request) async {
    if (request.email.isEmpty) {
      throw GrpcError.invalidArgument('Email not found');
    }
    if (request.password.isEmpty) {
      throw GrpcError.invalidArgument('Password not found');
    }
    final users = await repo
        .feathUsers(QueryParams(limit: 1, where: "email='${request.email}'"));
    if (users.isEmpty) {
      throw GrpcError.notFound("Пользователей с таким mail не существует");
    }
    checkPassword(request, users);
    try {
      final response =
          await _smsRpcClient.authSms(SmsRequestDto(email: request.email));
      repo.updateUser(UserUpdateRequest(
          id: users[0].id, code: response.sms, codeLife: response.smsLifeDate));
      return ResponseDto(message: "Код отправлен");
    } on Exception catch (error, trace) {
      throw GrpcError.internal(
          'ошибка в методе signInSms: ${error.toString()}, trace: $trace');
    }
  }

  void checkPassword(UserDto request, List<UserView> users) {
    final hashPassword = Utils.getHastPassword(request.password);
    if (hashPassword != users[0].password) {
      throw GrpcError.unauthenticated("Неправельный пароль");
    }
  }

  @override
  Future<TokensDto> sendSms(ServiceCall call, RequestDto request) async {
    if (request.code.isEmpty) {
      throw GrpcError.invalidArgument("код не найден");
    }
    if (request.email.isEmpty) {
      throw GrpcError.invalidArgument("почта не найден");
    }
    final users = await repo
        .feathUsers(QueryParams(limit: 1, where: "email='${request.email}'"));
    if (users.isEmpty) {
      throw GrpcError.notFound('пользователь не найден');
    }
    if (Utils.compareDateTime(DateTime.now().add(Duration(hours: 3)),
        Utils.convertStringToDateTime(users[0].codeLife!))) {
      throw GrpcError.unauthenticated("код не действительный ");
    }
    if (request.code != users[0].code) {
      throw GrpcError.unauthenticated(
          "Вы ввели неправильный или недействительный код");
    }
    return _createTokens(users[0].id.toString(), users[0].roleList);
  }

  String getRandomUsername() => UsernameGenerator().generateRandom();

  @override
  Future<ResponseDto> addRole(ServiceCall call, RoleDto request) async {
    if (request.userId.isEmpty) {
      throw GrpcError.invalidArgument("userId не найден");
    }
    if (request.roleName.isEmpty) {
      throw GrpcError.invalidArgument("roleName не найден");
    }
    final roles = await repo
        .feathRoles(QueryParams(limit: 1, where: "name='${request.roleName}'"));
    if (roles.isEmpty) {
      repo.addRole(RoleInsertRequest(
          name: request.roleName,
          isCreate: request.isCreate ?? false,
          isRead: request.isRead ?? false,
          isUpdate: request.isUpdate ?? false,
          isDelete: request.isDelete ?? false));
      return ResponseDto(message: "пользователю добавлена новая роль");
    }
    return ResponseDto(message: "пользователю добавлена роль");
  }
}
