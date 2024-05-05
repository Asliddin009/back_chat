import 'package:auth/data/entity/log/log.dart';
import 'package:auth/data/entity/role/role.dart';
import 'package:auth/data/entity/session/session.dart';
import 'package:auth/data/entity/user/user.dart';
import 'package:stormberry/stormberry.dart';

abstract interface class IRepo {
  //Авторизация
  Future<UserView?> feathUser(int id);
  Future<List<UserView>> feathUsers(QueryParams params);
  Future<int> addUser(UserInsertRequest userInsertRequest);
  Future<String> updateUser(UserUpdateRequest userUpdateRequest);
  Future<String> deleteUser(int id);

  //Сессия
  Future<SessionUserView?> feathSession(int id);
  Future<String> updateSession(SessionUserUpdateRequest sessionUpdateRequest);
  Future<int> createSession(SessionUserInsertRequest sessionInsertRequest);

  //Ролевая политика
  Future<List<String>> feathUserRoles(int userId);
  Future<List<RoleView>> feathRoles(QueryParams params);
  Future<String> addRole(int userId, String newRole);

  //логирование
  Future<List<LogView>> feathLogs(QueryParams params);
}
