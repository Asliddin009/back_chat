import 'dart:async';
import 'package:files/env.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class GrpcIntercetors {
  static FutureOr<GrpcError?> tokenInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) {
    try {
      final token = call.clientMetadata?['token'] ?? "";
      final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
      jwtClaim.validate();
      return null;
    } catch (error) {
      return GrpcError.unauthenticated();
    }
  }


}
