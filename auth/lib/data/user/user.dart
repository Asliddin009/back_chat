import 'package:stormberry/stormberry.dart';

part 'user.schema.dart';

@Model(indexes: [
  TableIndex(name: 'email', columns: ['email'], unique: true),
  TableIndex(name: 'username', columns: ['username'], unique: true),
  TableIndex(name: 'phone', columns: ['phone'], unique: true),
])
abstract class User {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get username;
  String? get email;
  String? get password;
  String? get phone;
  String? get avatar;
  String? get firstName;
  String? get lastName;
  String? get role;
  String? get code;
}
