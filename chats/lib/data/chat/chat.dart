import 'package:chats/data/message/message.dart';
import 'package:stormberry/stormberry.dart';

part 'chat.schema.dart';

@Model(views: [#Short, #Full])
abstract class Chat {
  @PrimaryKey()
  @AutoIncrement()
  int get id;
  String get name;
  String get authorId;
  String? get memberId;
  @HiddenIn(#Short)
  List<Message> get messages;
}
