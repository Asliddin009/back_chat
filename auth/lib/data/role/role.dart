import 'package:stormberry/stormberry.dart';

part "role.schema.dart";

@Model()
abstract class Role {
  @PrimaryKey()
  @AutoIncrement()
  int get id;
  String get name;
  bool get isCreate;
  bool get isRead;
  bool get isUpdate;
  bool get isDelete;
}
