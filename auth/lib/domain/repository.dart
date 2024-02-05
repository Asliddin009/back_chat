import 'package:auth/data/user/user.dart';
import 'package:stormberry/stormberry.dart';

abstract interface class IRepo {
  Future<UserView?> feathUser(dynamic id);
  Future<List<UserView>> feathUsers(QueryParams params);
  Future<int> addUser(UserInsertRequest userInsertRequest);
  Future<String> updateUser(UserUpdateRequest userUpdateRequest);
  Future<String> deleteUser(dynamic id);
}
