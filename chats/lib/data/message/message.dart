import 'package:stormberry/stormberry.dart';

part 'message.schema.dart';

@Model()
abstract class Message {
  @PrimaryKey()
  @AutoIncrement()
  int get id;
  String get body;
  String get authorId;
}
