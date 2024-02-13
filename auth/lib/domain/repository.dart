import 'package:auth/data/role/role.dart';
import 'package:auth/data/user/user.dart';
import 'package:stormberry/stormberry.dart';

abstract interface class IRepo {
  //Авторизация
  Future<UserView?> feathUser(dynamic id);
  Future<List<UserView>> feathUsers(QueryParams params);
  Future<int> addUser(UserInsertRequest userInsertRequest);
  Future<String> updateUser(UserUpdateRequest userUpdateRequest);
  Future<String> deleteUser(dynamic id);

  //Ролевая политика
  Future<int> addUserRole(int userId, {roleId = 3});
  Future<List<RoleView>> feathRoles(QueryParams params);
  Future<int> addRole(RoleInsertRequest roleInsertRequest);
}
