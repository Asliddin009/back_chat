import 'dart:async';

import 'package:auth/data/db.dart';
import 'package:auth/data/intercetors/check_db.dart';
import 'package:auth/data/entity/log/log.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';

final excludeMethods = [
  'SignUp',
  'SignIn',
  'RefreshToken',
  'SendSms',
  'SignInSms',
  'RecallToken'
];

abstract class LogIntercetors {
  static FutureOr<GrpcError?> logInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) async {
    ckeckDatabase();
    try {
      final callDate = Utils.convertDateTimeToString(DateTime.now());
      String userId;
      if (excludeMethods.contains(serviceMethod.name)) {
        userId = 'Не авторизован';
      } else {
        userId = Utils.getIdFromToken(call.clientMetadata?['token'] ?? "")
            .toString();
      }
      await db.logs.insertOne(LogInsertRequest(
          userId: userId, method: serviceMethod.name, callDate: callDate));
      return null;
    } catch (error) {
      return GrpcError.unauthenticated('ошибка логирования');
    }
  }
}
