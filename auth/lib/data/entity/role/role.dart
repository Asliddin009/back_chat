import 'package:auth/data/entity/user/user.dart';
import 'package:stormberry/stormberry.dart';

part "role.schema.dart";

@Model()
abstract class Role {
  @PrimaryKey()
  @AutoIncrement()
  int get id;
  User get user;
  String? get role;
}
