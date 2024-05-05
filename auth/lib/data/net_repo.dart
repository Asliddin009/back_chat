import 'package:auth/data/entity/log/log.dart';
import 'package:auth/data/entity/role/role.dart';
import 'package:auth/data/entity/session/session.dart';
import 'package:auth/data/entity/user/user.dart';
import 'package:auth/domain/repository.dart';
import 'package:auth/data/db.dart';
import 'package:stormberry/stormberry.dart';

final class NetRepo implements IRepo {
  //АВТОРИЗАЦИЯ

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
    await db.roles
        .insertOne(RoleInsertRequest(userId: id, role: "updateUser, "));
    return id;
  }

  @override
  Future<String> updateUser(UserUpdateRequest userUpdateRequest) async {
    await db.users.updateOne(userUpdateRequest);
    return "successful";
  }

  @override
  Future<String> deleteUser(id) async {
    try {
      final listRoles =
          await db.roles.queryRoles(QueryParams(where: "user_id = '$id'"));
      await db.roles.deleteOne(listRoles[0].id);
      await db.users.deleteOne(id);
      return "successful";
    } on Exception catch (e) {
      print("ошибка в методе deleteUser: $e");
      rethrow;
    }
  }

  //РОЛЕВАЯ ПОЛИТИКА
  @override
  Future<List<RoleView>> feathRoles(QueryParams params) async {
    final res = await db.roles.queryRoles(params);
    return res;
  }

  @override
  Future<List<String>> feathUserRoles(int userId) async {
    final query = "user_id = '$userId'";
    final list = await db.roles.queryRoles(QueryParams(where: query, limit: 1));
    return list[0].role!.split(",");
  }

  @override
  Future<String> addRole(int userId, String newRole) async {
    try {
      final res = await db.roles
          .queryRoles(QueryParams(limit: 1, where: "user_id='$userId'"));
      if (res.isEmpty) {
        await db.roles
            .insertOne(RoleInsertRequest(userId: userId, role: newRole));
        return 'пользователю добавлена новая роль';
      } else {
        final oldRole = res[0].role;
        late final String finishRole;
        if (newRole == 'admin') {
          finishRole = "$newRole,$oldRole";
        } else {
          finishRole = "$oldRole,$newRole";
        }
        await db.roles
            .updateOne(RoleUpdateRequest(id: res[0].id, role: finishRole));
        return 'пользователю добавлена роль';
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  //ЛОГИ
  @override
  Future<List<LogView>> feathLogs(QueryParams params) async {
    final list = await db.logs.queryLogs(params);
    return list;
  }

  //СЕССИИ
  @override
  Future<SessionUserView?> feathSession(int id) async {
    final res = await db.sessionUsers
        .querySessionUsers(QueryParams(limit: 1, where: "user_id='$id'"));
    if (res.isEmpty) return null;
    return res[0];
  }

  @override
  Future<String> updateSession(
      SessionUserUpdateRequest sessionUpdateRequest) async {
    await db.sessionUsers.updateOne(sessionUpdateRequest);
    return "successful";
  }

  @override
  Future<int> createSession(
      SessionUserInsertRequest sessionInsertRequest) async {
    final id = await db.sessionUsers.insertOne(sessionInsertRequest);
    return id;
  }
}
