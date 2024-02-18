import 'dart:async';

import 'package:auth/data/db.dart';
import 'package:auth/data/intercetors/check_db.dart';
import 'package:auth/data/entity/log/log.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';

abstract class LogIntercetors {
  static FutureOr<GrpcError?> logInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) {
    ckeckDatabase();
    try {
      final callDate = Utils.convertDateTimeToString(DateTime.now());
      int userId;
      if (excludeMethods.contains(serviceMethod.name)) {
        userId = 0;
      } else {
        userId = Utils.getIdFromToken(call.clientMetadata?['token'] ?? "");
      }
      print('test');
      db.logs.insertOne(LogInsertRequest(
          userId: userId, method: serviceMethod.name, callDate: callDate));
      print('test2');

      return null;
    } catch (error) {
      return GrpcError.unauthenticated('ошибка логирования');
    }
  }
}
