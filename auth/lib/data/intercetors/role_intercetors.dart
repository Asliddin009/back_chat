import 'dart:async';
import 'package:auth/data/db.dart';
import 'package:auth/data/intercetors/check_db.dart';
import 'package:auth/data/role/role.dart';
import 'package:auth/env.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:stormberry/stormberry.dart';

final _excludeMethods = [
  'SignUp',
  'SignIn',
  'RefreshToken',
  'SendSms',
  'SignInSms'
];

abstract class RoleIntercetors {
  static FutureOr<GrpcError?> roleInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) async {
    ckeckDatabase();
    final listId = getRoleFromMetadata(call);
    final list =
        await db.roles.queryRoles(QueryParams(where: "id = '${listId[0]}'"));
    print("list = ${list}");
    try {
      return null;
    } catch (error) {
      return GrpcError.permissionDenied('У вас не хватает прав');
    }
  }

  static List<String> getRoleFromMetadata(ServiceCall serviceCall) {
    final accessToken = serviceCall.clientMetadata?['token'] ?? "";
    final jwtClaim = verifyJwtHS256Signature(accessToken, Env.sk);
    final listId = Utils.convertStringToList(jwtClaim['role_id']);
    return listId;
  }
}
