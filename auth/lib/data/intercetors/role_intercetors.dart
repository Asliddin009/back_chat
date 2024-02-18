import 'dart:async';
import 'dart:io';
import 'package:auth/data/db.dart';
import 'package:auth/data/intercetors/check_db.dart';
import 'package:auth/data/entity/role/role.dart';
import 'package:auth/env.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

final _methodsForAdmin = [
  'AddRole',
];

final _methodsWithCreatePermission = [
  'AddRole',
];

final _methodsWithUpdatePermission = [
  'UpdateOtherUser',
];

final _methodsWithReadPermission = [
  'FetchUser',
  'FindUser',
];

final _methodsWithDeletePermission = [
  'DeleteOtherUser',
];

abstract class RoleIntercetors {
  static FutureOr<GrpcError?> roleInterceptor(
      ServiceCall call, ServiceMethod serviceMethod) async {
    ckeckDatabase();
    if (excludeMethods.contains(serviceMethod.name)) return null;
    final listId = getRoleFromMetadata(call);
    if (listId.contains('1') && _methodsForAdmin.contains(serviceMethod.name)) {
      return null; //проверка на админа
    }
    try {
      for (var element in listId) {
        print(element);
        final role = await db.roles.queryRole(int.parse(element));
        if (checkRole(role, serviceMethod)) return null;
      }
      return GrpcError.permissionDenied('У вас не хватает прав');
    } catch (error) {
      return GrpcError.internal('ошибка при обработке роли');
    }
  }

  static List<String> getRoleFromMetadata(ServiceCall serviceCall) {
    try {
      final accessToken = serviceCall.clientMetadata?['token'] ?? "";
      final jwtClaim = verifyJwtHS256Signature(accessToken, Env.sk);
      final listId = Utils.convertStringToList(jwtClaim['role_id']);
      return listId;
    } on Exception catch (_) {
      rethrow;
    }
  }

  static bool checkRole(RoleView? roleView, ServiceMethod method) {
    if (_methodsWithUpdatePermission.contains(method.name)) {
      return roleView!.isUpdate;
    }
    if (_methodsWithCreatePermission.contains(method.name)) {
      return roleView!.isCreate;
    }
    if (_methodsWithReadPermission.contains(method.name)) {
      return roleView!.isRead;
    }
    if (_methodsWithDeletePermission.contains(method.name)) {
      return roleView!.isDelete;
    }
    return false;
  }
}
