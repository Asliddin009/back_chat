import 'package:files/env.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class Utils {
  static int getIdFromToken(String token) {
    final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
    final id = int.tryParse(jwtClaim['user_id']);
    if (id == null) throw GrpcError.dataLoss("User id not found");
    return id;
  }

  static int getIdFromMetadata(ServiceCall call) {
    try {
      final accessToken = call.clientMetadata?['token'] ?? "";
      return getIdFromToken(accessToken);
    } catch (e) {
      throw GrpcError.unauthenticated("Токен не валидный");
    }
  }
}
