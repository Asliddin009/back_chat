import 'dart:convert';

import 'package:chats/env.dart';
import 'package:crypto/crypto.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class Utils {
  static getIdFromToken(String token) {
    final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
    final id = int.tryParse(jwtClaim['user_id']);
    if (id == null) throw GrpcError.dataLoss("User id not found");
    return id;
  }

  static getIdFromMetadata(ServiceCall serviceCall) {
    final accessToken = serviceCall.clientMetadata?['access_token'] ?? "";
    return getIdFromToken(accessToken);
  }
}
