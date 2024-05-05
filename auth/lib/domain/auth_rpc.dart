import 'dart:isolate';
import 'package:auth/data/entity/session/session.dart';
import 'package:auth/data/entity/user/user.dart';
import 'package:auth/domain/repository.dart';
import 'package:auth/env.dart';
import 'package:auth/generated/auth_sms.pbgrpc.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:stormberry/stormberry.dart';

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
    return _createTokens(user.id.toString());
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
    final token = await _createTokens(user.id.toString());
    checkSession(user.id, token);
    return token;
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
      var id = await repo.addUser(UserInsertRequest(
        username: request.username,
        email: request.email,
        password: Utils.getHastPassword(request.password),
      ));
      print("test");
      final token = await _createTokens(id.toString());
      checkSession(id, token);
      return token;
    } on Exception catch (_) {
      throw GrpcError.unavailable('пользователь уже зарегестрирован');
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

  ///создать токен
  Future<TokensDto> _createTokens(
    String id,
  ) async {
    final accessTokenSet =
        JwtClaim(maxAge: Duration(minutes: Env.accessTokenLife), otherClaims: {
      'user_id': id,
    });
    final refreshTokenSet =
        JwtClaim(maxAge: Duration(minutes: Env.refreshTokenLife), otherClaims: {
      'user_id': id,
    });
    return TokensDto(
        accessToken: issueJwtHS256(accessTokenSet, Env.sk),
        refreshToken: issueJwtHS256(refreshTokenSet, Env.sk));
  }

  ///Найти пользвателя
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

  ///Авторизация по смс
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

  ///Проверка пароля
  void checkPassword(UserDto request, List<UserView> users) {
    final hashPassword = Utils.getHastPassword(request.password);
    if (hashPassword != users[0].password) {
      throw GrpcError.unauthenticated("Неправельный пароль");
    }
  }

  ///Проверка код из почты
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
    repo.updateUser(UserUpdateRequest(id: users[0].id, code: ''));
    final token = await _createTokens(
      users[0].id.toString(),
    );
    checkSession(users[0].id, token);
    return token;
  }

  ///Добавление пользователя
  @override
  Future<ResponseDto> addRole(ServiceCall call, RoleDto request) async {
    if (request.userId.isEmpty) {
      throw GrpcError.invalidArgument("userId не найден");
    }
    if (request.roleName.isEmpty) {
      throw GrpcError.invalidArgument("roleName не найден");
    }
    final id = Utils.getIdFromMetadata(call);
    final rolePermission = await checkRole('admin', id);
    if (rolePermission == false) {
      throw GrpcError.unauthenticated("У вас нет прав");
    }
    try {
      final userId = int.parse(request.userId);
      final res = await repo.addRole(userId, request.roleName);
      return ResponseDto(message: res);
    } catch (error, trace) {
      throw GrpcError.internal(
          'ошибка в методе addRole: ${error.toString()}, trace: $trace');
    }
  }

  ///Удаление другого пользователя
  @override
  Future<ResponseDto> deleteOtherUser(ServiceCall call, UserDto request) async {
    if (request.id.isEmpty) {
      throw GrpcError.invalidArgument("id не найден");
    }
    final userDeleteId = int.parse(request.id);
    final user = await repo.feathUser(userDeleteId);
    if (user == null) throw GrpcError.notFound("Пользователь не найден");
    final id = Utils.getIdFromMetadata(call);
    final rolePermission = await checkRole('deleteUser', id);
    if (rolePermission == false) {
      throw GrpcError.unauthenticated('У вас нет прав');
    }
    try {
      repo.deleteUser(id);
      return ResponseDto(message: "Пользователь удален");
    } on Exception catch (error, trace) {
      throw GrpcError.internal(
          'ошибка в методе deleteOtherUser: ${error.toString()}, trace: $trace');
    }
  }

  Future<bool> checkRole(String role, int userId) async {
    final listRole = await repo.feathUserRoles(userId);
    if (listRole.isEmpty) return false;
    return listRole.contains(role);
  }

  ///Обновление другого пользователя
  @override
  Future<ResponseDto> updateOtherUser(ServiceCall call, UserDto request) async {
    if (request.id.isEmpty) {
      throw GrpcError.invalidArgument("id не найден");
    }
    final userUpdateId = int.parse(request.id);
    final id = Utils.getIdFromMetadata(call);
    final rolePermission = await checkRole('updateUser', id);
    if (rolePermission == false) {
      throw GrpcError.unauthenticated('У вас нет прав');
    }
    try {
      repo.updateUser(UserUpdateRequest(
          id: userUpdateId,
          username: request.username.isEmpty ? null : request.username,
          email: request.email.isEmpty ? null : request.email,
          password: request.password.isEmpty
              ? null
              : Utils.getHastPassword(request.password)));
      return ResponseDto(message: "пользователь обновлен");
    } on Exception catch (error, trace) {
      throw GrpcError.internal(
          'ошибка в методе updateOtherUser: ${error.toString()}, trace: $trace');
    }
  }

  ///Получение всех логов
  @override
  Future<ResponseDto> getAllLogs(ServiceCall call, UserDto request) async {
    final key = " ";
    final query = "username LIKE '%$key%'";
    final list = repo.feathLogs(QueryParams(where: query));

    return ResponseDto(message: list.toString());
  }

  ///Проверка сессии
  void checkSession(int userId, TokensDto token) async {
    final session = await repo.feathSession(userId);
    if (session == null) {
      await repo.createSession(SessionUserInsertRequest(
          userId: userId, listToken: [token.accessToken]));
      return null;
    }
    if (session.listToken.length < Env.countSession) {
      final list = session.listToken..add(token.accessToken);
      await repo.updateSession(SessionUserUpdateRequest(
          id: session.id, userId: userId, listToken: list));
      print("сессия обновлена");
    } else {
      final list = session.listToken.sublist(1, session.listToken.length)
        ..add(token.accessToken);
      await repo.updateSession(SessionUserUpdateRequest(
          id: session.id, userId: userId, listToken: list));
      print("сессия обновлена самая старая сессия теперь не активна");
    }
  }

  ///Отозвать все токены
  @override
  Future<ResponseDto> recallToken(ServiceCall call, TokensDto request) async {
    if (request.accessToken.isEmpty) {
      throw GrpcError.notFound("accessToken not found");
    }
    final id = Utils.getIdFromToken(request.accessToken);
    final session = await repo.feathSession(id);
    if (session == null) {
      throw GrpcError.unauthenticated("не найдено сессий с этим токеном");
    }
    await repo.updateSession(SessionUserUpdateRequest(
        id: session.id, listToken: [request.accessToken]));
    return ResponseDto(
        message: "все токены отозваны, кроме ${request.accessToken}");
  }
}
