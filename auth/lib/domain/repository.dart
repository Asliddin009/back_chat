import 'package:auth/data/entity/log/log.dart';
import 'package:auth/data/entity/role/role.dart';
import 'package:auth/data/entity/user/user.dart';
import 'package:stormberry/stormberry.dart';

abstract interface class IRepo {
  //Авторизация
  Future<UserView?> feathUser(int id);
  Future<List<UserView>> feathUsers(QueryParams params);
  Future<int> addUser(UserInsertRequest userInsertRequest);
  Future<String> updateUser(UserUpdateRequest userUpdateRequest);
  Future<String> deleteUser(int id);

  //Ролевая политика
  Future<int> addUserRole(int userId, {int roleId = 3});
  Future<List<RoleView>> feathRoles(QueryParams params);
  Future<int> addRole(RoleInsertRequest roleInsertRequest);

  //логирование
  Future<List<LogView>> feathLogs(QueryParams params);
}
