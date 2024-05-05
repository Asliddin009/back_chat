import 'dart:async';

import 'package:auth/data/db.dart';
import 'package:auth/data/entity/session/session.dart';
import 'package:auth/data/intercetors/check_db.dart';
import 'package:auth/env.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:stormberry/stormberry.dart';

final excludeMethods = [
  'SignUp',
  'SignIn',
  'RefreshToken',
  'SendSms',
  'SignInSms',
  'RecallToken'
];

abstract class TokenIntercetors {
  static FutureOr<GrpcError?> tokenInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) async {
    ckeckDatabase();
    try {
      if (excludeMethods.contains(serviceMethod.name)) return null;
      final token = call.clientMetadata?['token'] ?? "";
      final jwtClaim = verifyJwtHS256Signature(token, Env.sk);
      jwtClaim.validate();
      final res = await db.sessionUsers.querySessionUsers(QueryParams(
          limit: 1, where: "user_id='${Utils.getIdFromToken(token)}'"));
      if (res.isEmpty) return null;
      if (!res[0].listToken.contains(token)) {
        return GrpcError.unauthenticated("сессия закрыта");
      }
      return null;
    } catch (error) {
      return GrpcError.unauthenticated('токен недействительный');
    }
  }
}
