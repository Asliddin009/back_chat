// import 'package:auth/data/entity/log/log.dart';
// import 'package:auth/data/entity/role/role.dart';
// import 'package:auth/data/entity/session/session.dart';
// import 'package:auth/data/entity/user/user.dart';
// import 'package:auth/domain/repository.dart';
// import 'package:stormberry/stormberry.dart' show QueryParams;

// final class MockRepo implements IRepo {
//   @override
//   Future<UserView?> feathUser(id) {
//     return Future.value(UserView(
//       id: 1,
//       username: 'test',
//       email: 'test@mail.ru',
//     ));
//   }

//   @override
//   Future<List<UserView>> feathUsers(QueryParams params) {
//     return Future.value([
//       UserView(
//         id: 1,
//         username: 'test1',
//         email: 'test1@mail.ru',
//       ),
//       UserView(
//         id: 2,
//         username: 'test2',
//         email: 'test2@mail.ru',
//       ),
//       UserView(
//         id: 3,
//         username: 'test3',
//         email: 'test3@mail.ru',
//       )
//     ]);
//   }

//   @override
//   Future<int> addUser(UserInsertRequest userInsertRequest) {
//     return Future.value(1);
//   }

//   @override
//   Future<String> deleteUser(id) {
//     return Future.value('successful');
//   }

//   @override
//   Future<String> updateUser(UserUpdateRequest userUpdateRequest) {
//     return Future.value('successful');
//   }
  
//   @override
//   Future<String> addRole(RoleInsertRequest roleInsertRequest) {
//     // TODO: implement addRole
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<int> addUserRole(int userId, {String roleName = "3"}) {
//     // TODO: implement addUserRole
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<List<LogView>> feathLogs(QueryParams params) {
//     // TODO: implement feathLogs
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<List<RoleView>> feathRoles(QueryParams params) {
//     // TODO: implement feathRoles
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<SessionView?> feathSession(int id) {
//     // TODO: implement feathSession
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<String> updateSession(SessionUpdateRequest sessionUpdateRequest) {
//     // TODO: implement updateSession
//     throw UnimplementedError();
//   }

  
//   }

//   @override
//   Future<List<LogView>> feathLogs(QueryParams params) {
//     // TODO: implement feathLogs
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<RoleView>> feathRoles(QueryParams params) {
//     // TODO: implement feathRoles
//     throw UnimplementedError();
//   }

//   @override
//   Future<SessionView?> feathSession(int id) {
//     // TODO: implement feathSession
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> updateSession(SessionUpdateRequest sessionUpdateRequest) {
//     // TODO: implement updateSession
//     throw UnimplementedError();
//   }
// }
