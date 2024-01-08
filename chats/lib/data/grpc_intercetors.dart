import 'dart:async';
import 'package:chats/data/db.dart';
import 'package:chats/env.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class GrpcIntercetors {
  static FutureOr<GrpcError?> tokenInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) {
    _ckeckDatabase();
    try {
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
