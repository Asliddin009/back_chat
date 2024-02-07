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

  static int getIdFromToken(String token) {
    final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
    final id = int.tryParse(jwtClaim['user_id']);
    if (id == null) throw GrpcError.dataLoss("User id not found");
    return id;
  }

  static getIdFromMetadata(ServiceCall serviceCall) {
    final accessToken = serviceCall.clientMetadata?['token'] ?? "";
    return getIdFromToken(accessToken);
  }

  static UserDto getUserDtoFromUserVeiw(UserView user) {
    return UserDto(
        id: user.id.toString(),
        username: user.username.toString(),
        email: user.email.toString());
  }

  static bool areUserDtoEqual(UserDto user1, UserDto user2) {
    return user1.id == user2.id &&
        user1.username == user2.username &&
        user1.email == user2.email;
  }

  static DateTime convertStringToDateTime(String yyyymmdd) {
    int yyyy = int.parse(yyyymmdd.substring(0, 4));
    int mm = int.parse(yyyymmdd.substring(5, 7));
    int dd = int.parse(yyyymmdd.substring(8, 10));
    late DateTime dateTimeObject;
    dateTimeObject = DateTime(yyyy, mm, dd);
    return dateTimeObject;
  }

  static bool compareDateTime(DateTime dateTime1, DateTime dateTime2) {
    if (dateTime1.year > dateTime2.year) return true;
    if (dateTime1.day > dateTime2.day) return true;
    if (dateTime1.minute > dateTime2.minute) return true;
    return false;
  }

  static ListUserDto parseUsers(List<UserView> users) {
    try {
      return ListUserDto(
          users: [...users.map((user) => getUserDtoFromUserVeiw(user))]);
    } catch (error) {
      throw GrpcError.internal("Ошибка в методе parseUsers");
    }
  }
}
