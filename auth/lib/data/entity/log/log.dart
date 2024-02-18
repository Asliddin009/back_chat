import 'package:stormberry/stormberry.dart';

part 'log.schema.dart';

@Model()
abstract class Log {
  @PrimaryKey()
  @AutoIncrement()
  int get id;
  int get userId;
  String get method;
  String get callDate;
}
