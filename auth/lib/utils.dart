import 'dart:convert';

import 'package:auth/data/user/user.dart';
import 'package:auth/env.dart';
import 'package:auth/generated/auth.pbgrpc.dart';
import 'package:crypto/crypto.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class Utils {
  static String getHastPassword(String password) {
    final bytes = utf8.encode(password + Env.sk);
    return sha256.convert(bytes).toString();
  }

  static getIdFromToken(String token) {
    final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
    final id = int.tryParse(jwtClaim['user_id']);
    if (id == null) throw GrpcError.dataLoss("User id not found");
    return id;
  }

  static getIdFromMetadata(ServiceCall serviceCall) {
    final accessToken = serviceCall.clientMetadata?['token'] ?? "";
    return getIdFromToken(accessToken);
  }

  static getUserDtoFromUserVeiw(UserView user) {
    return UserDto(
        id: user.id.toString(),
        username: user.username.toString(),
        email: user.email.toString());
  }

  static ListUserDto parseUsers(List<UserView> users) {
    try {
      return ListUserDto(
          users: [...users.map((user) => getUserDtoFromUserVeiw(user))]);
    } catch (error) {
      throw GrpcError.internal("Ошибка в методе parseUsers");
      //return ListUserDto(users: []);
    }
  }
}
