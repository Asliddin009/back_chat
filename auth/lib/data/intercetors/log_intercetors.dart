import 'dart:async';

import 'package:auth/data/db.dart';
import 'package:auth/data/intercetors/check_db.dart';
import 'package:auth/env.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

final _excludeMethods = [
  'SignUp',
  'SignIn',
  'RefreshToken',
  'SendSms',
  'SignInSms'
];

abstract class LogIntercetors {
  static FutureOr<GrpcError?> logInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) {
    ckeckDatabase();
    try {
      return null;
    } catch (error) {
      return GrpcError.unauthenticated('ошибка логирования');
    }
  }
}
