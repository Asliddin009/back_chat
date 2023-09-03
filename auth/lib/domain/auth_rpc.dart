import 'dart:developer';

import 'package:auth/data/db.dart';
import 'package:auth/data/user/user.dart';
import 'package:auth/env.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/src/server/call.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:stormberry/stormberry.dart';

import '../generated/auth.pbgrpc.dart';

class AuthRpc extends AuthRpcServiceBase {
  @override
  Future<ResponseDto> deleteUser(ServiceCall call, RequestDto request) async {
    final id = Utils.getIdFromMetadata(call);
    final user = await db.users.queryUser(id);
    if (user == null) throw GrpcError.notFound("Пользователь не найден");

    await db.users.deleteOne(id);
    return ResponseDto(message: "Пользователь удален");
  }

  @override
  Future<UserDto> fetchUser(ServiceCall call, RequestDto request) async {
    final id = Utils.getIdFromMetadata(call);
    final user = await db.users.queryUser(id);
    if (user == null) throw GrpcError.notFound("Пользователь не найден");
    return Utils.getUserDtoFromUserVeiw(user);
  }

  @override
  Future<TokensDto> refreshToken(ServiceCall call, TokensDto request) async {
    if (request.refreshToken.isEmpty) {
      throw GrpcError.invalidArgument('Email not found');
    }
    final id = Utils.getIdFromToken(request.refreshToken);
    final user = await db.users.queryUser(id);
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
    final users = await db.users
        .queryUsers(QueryParams(where: "email='${request.email}'"));
    if (users.isEmpty) {
      throw GrpcError.notFound("Пользователей с таким mail не существует");
    }
    final user = users[0];
    if (hashPassword != user.password) {
      throw GrpcError.unauthenticated("Неправельный пароль");
    }
    return _createTokens(user.id.toString());
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
      final id = await db.users.insertOne(UserInsertRequest(
        username: request.username,
        email: request.email,
        password: Utils.getHastPassword(request.password),
      ));
      return _createTokens(id.toString());
    } catch (error) {
      log('$error');
      throw GrpcError.notFound("Такой пользователь уже существует");
      //return TokensDto();
    }
  }

  @override
  Future<UserDto> updateUser(ServiceCall call, UserDto request) async {
    final id = Utils.getIdFromMetadata(call);
    await db.users.updateOne(UserUpdateRequest(
        id: id,
        username: request.username.isEmpty ? null : request.username,
        email: request.email.isEmpty ? null : request.email,
        password: request.password.isEmpty
            ? null
            : Utils.getHastPassword(request.password)));
    final user = await db.users.queryUser(id);
    if (user == null) throw GrpcError.notFound("Что то пошло не так");
    return Utils.getUserDtoFromUserVeiw(user);
  }

  TokensDto _createTokens(String id) {
    final accessTokenSet = JwtClaim(
        maxAge: Duration(hours: Env.accessTokenLife),
        otherClaims: {'user_id': id});
    final refreshTokenSet = JwtClaim(
        maxAge: Duration(hours: Env.refreshTokenLife),
        otherClaims: {'user_id': id});
    return TokensDto(
        accessToken: issueJwtHS256(accessTokenSet, Env.sk),
        refreshToken: issueJwtHS256(refreshTokenSet, Env.sk));
  }
}
