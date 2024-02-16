import 'dart:async';

import 'package:auth/data/intercetors/check_db.dart';
import 'package:auth/env.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class TokenIntercetors {
  static FutureOr<GrpcError?> tokenInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) {
    ckeckDatabase();
    try {
      if (excludeMethods.contains(serviceMethod.name)) return null;
      final token = call.clientMetadata?['token'] ?? "";
      final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
      jwtClaim.validate();
      return null;
    } catch (error) {
      return GrpcError.unauthenticated('токен недействительный');
    }
  }
}
