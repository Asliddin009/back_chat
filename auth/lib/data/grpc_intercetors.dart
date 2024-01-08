import 'dart:async';

import 'package:auth/data/db.dart';
import 'package:auth/env.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

final _excludeMethods = ['SignUp', 'SignIn', 'RefreshToken'];

abstract class GrpcIntercetors {
  static FutureOr<GrpcError?> tokenInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) {
    _ckeckDatabase();
    try {
      if (_excludeMethods.contains(serviceMethod.name)) return null;
      final token = call.clientMetadata?['token'] ?? "";
      final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
      jwtClaim.validate();
      return null;
    } catch (error) {
      return GrpcError.unauthenticated();
    }
  }

  static void _ckeckDatabase() {
    if (db.connection().isClosed) {
      db = initDatabase();
    }
  }
}
