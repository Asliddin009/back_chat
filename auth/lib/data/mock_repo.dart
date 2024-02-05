import 'package:auth/data/user/user.dart';
import 'package:auth/domain/repository.dart';
import 'package:stormberry/src/core/query_params.dart';

final class MockRepo implements IRepo {
  @override
  Future<UserView?> feathUser(id) {
    return Future.value(
        UserView(id: 1, username: 'test', email: 'test@mail.ru'));
  }

  @override
  Future<List<UserView>> feathUsers(QueryParams params) {
    return Future.value([
      UserView(id: 1, username: 'test1', email: 'test1@mail.ru'),
      UserView(id: 2, username: 'test2', email: 'test2@mail.ru'),
      UserView(id: 3, username: 'test3', email: 'test3@mail.ru')
    ]);
  }

  @override
  Future<int> addUser(UserInsertRequest userInsertRequest) {
    return Future.value(1);
  }

  @override
  Future<String> deleteUser(id) {
    return Future.value('successful');
  }

  @override
  Future<String> updateUser(UserUpdateRequest userUpdateRequest) {
    return Future.value('successful');
  }
}
