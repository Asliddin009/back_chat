import 'package:auth/data/entity/log/log.dart';
import 'package:auth/data/entity/role/role.dart';
import 'package:auth/data/entity/role_user/role_user.dart';
import 'package:auth/data/entity/user/user.dart';
import 'package:auth/domain/repository.dart';
import 'package:auth/data/db.dart';
import 'package:stormberry/stormberry.dart';

final class NetRepo implements IRepo {
  @override
  Future<UserView?> feathUser(dynamic id) async {
    final res = await db.users.queryUser(id);
    return res;
  }

  @override
  Future<List<UserView>> feathUsers(QueryParams params) async {
    final res = await db.users.queryUsers(params);
    return res;
  }

  @override
  Future<int> addUser(UserInsertRequest userInsertRequest) async {
    final id = await db.users.insertOne(userInsertRequest);
    return id;
  }

  @override
  Future<String> updateUser(UserUpdateRequest userUpdateRequest) async {
    await db.users.updateOne(userUpdateRequest);
    return "successful";
  }

  @override
  Future<String> deleteUser(id) async {
    await db.users.deleteOne(id);
    return "successful";
  }

  @override
  Future<int> addUserRole(int userId, {roleId = 3}) async {
    try {
      final id = await db.roleUsers
          .insertOne(RoleUserInsertRequest(roleId: roleId, userId: userId));
      return id;
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<RoleView>> feathRoles(QueryParams params) async {
    final res = await db.roles.queryRoles(params);
    return res;
  }

  @override
  Future<int> addRole(RoleInsertRequest roleInsertRequest) async {
    final id = await db.roles.insertOne(roleInsertRequest);
    return id;
  }

  @override
  Future<List<LogView>> feathLogs(QueryParams params) async {
    final list = await db.logs.queryLogs(params);
    return list;
  }
}
