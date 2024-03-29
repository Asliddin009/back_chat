import 'dart:convert';

import 'package:auth/data/entity/user/user.dart';
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
    try {
      final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
      final id = int.tryParse(jwtClaim['user_id']);
      if (id == null) throw GrpcError.dataLoss("User id not found");
      return id;
    } on Exception catch (_) {
      rethrow;
    }
  }

  static getIdFromMetadata(ServiceCall serviceCall) {
    try {
      final accessToken = serviceCall.clientMetadata?['token'] ?? "";
      return getIdFromToken(accessToken);
    } on Exception catch (_) {
      rethrow;
    }
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
    int dd = int.parse(yyyymmdd.substring(0, 2));
    int mm = int.parse(yyyymmdd.substring(3, 5));
    int yyyy = int.parse(yyyymmdd.substring(6, 10));
    int hh = int.parse(yyyymmdd.substring(11, 13));
    int min = int.parse(yyyymmdd.substring(14, 16));

    late DateTime dateTimeObject;
    dateTimeObject = DateTime(yyyy, mm, dd, hh, min);
    return dateTimeObject;
  }

  static bool compareDateTime(DateTime dateTime1, DateTime dateTime2) {
    if (dateTime1.year > dateTime2.year) return true;
    if (dateTime1.day > dateTime2.day) return true;
    if (dateTime1.minute > dateTime2.minute) return true;
    return false;
  }

  static String convertListToString(List<int> list) {
    return list.toString();
  }

  static List<String> convertStringToList(String input) {
    try {
      input = input.substring(1, input.length - 1);
      List<String> list = input.split(',');
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }

  static ListUserDto parseUsers(List<UserView> users) {
    try {
      return ListUserDto(
          users: [...users.map((user) => getUserDtoFromUserVeiw(user))]);
    } catch (error) {
      throw GrpcError.internal("Ошибка в методе parseUsers");
    }
  }

  static String convertDateTimeToString(DateTime dateTime) {
    String year = dateTime.year.toString();

    String month = dateTime.month.toString();
    if (month.length == 1) {
      month = '0$month';
    }

    String day = dateTime.day.toString();
    if (day.length == 1) {
      day = '0$day';
    }

    String hour = dateTime.hour.toString();
    if (hour.length == 1) {
      hour = '0$hour';
    }

    String minute = dateTime.minute.toString();
    if (minute.length == 1) {
      minute = '0$minute';
    }
    String ddmmyyyyhhmm = "$day.$month.$year $hour:$minute";
    return ddmmyyyyhhmm;
  }
}
