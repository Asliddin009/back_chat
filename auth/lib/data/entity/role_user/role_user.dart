import 'package:auth/data/entity/role/role.dart';
import 'package:auth/data/entity/user/user.dart';
import 'package:stormberry/stormberry.dart';

part "role_user.schema.dart";

@Model()
abstract class RoleUser {
  @PrimaryKey()
  @AutoIncrement()
  int get id;
  Role get role;
  User get user;
}
