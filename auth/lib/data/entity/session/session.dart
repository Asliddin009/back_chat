import 'package:auth/data/entity/user/user.dart';
import 'package:stormberry/stormberry.dart';

part 'session.schema.dart';

@Model()
abstract class Session {
  @PrimaryKey()
  @AutoIncrement()
  int get id;
  User get user;
  List<String> get listToken;
}
