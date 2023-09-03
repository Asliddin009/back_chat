import 'package:stormberry/stormberry.dart';

part 'user.schema.dart';

@Model(indexes: [
  TableIndex(name: 'email', columns: ['email'], unique: true),
  TableIndex(name: 'username', columns: ['username'], unique: true),
])
abstract class User {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get username;
  String get email;
  String get password;
}
