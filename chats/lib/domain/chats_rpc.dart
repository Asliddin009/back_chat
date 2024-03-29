import 'dart:async';
import 'dart:isolate';

import 'package:chats/data/chat/chat.dart';
import 'package:chats/data/db.dart';
import 'package:chats/data/message/message.dart';
import 'package:chats/generated/chats.pbgrpc.dart';
import 'package:chats/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/protobuf.dart';
import 'package:stormberry/stormberry.dart';

class ChatRpc extends ChatsRpcServiceBase {
  final StreamController<MessageDto> streamController =
      StreamController.broadcast();
  @override
  Future<ResponseDto> createChat(ServiceCall call, ChatDto request) async {
    final id = Utils.getIdFromMetadata(call);
    if (request.name.isEmpty) {
      throw GrpcError.invalidArgument("Название чата не валидное");
    }
    if (request.memberId.isEmpty) {
      throw GrpcError.invalidArgument("id других участников не найдено");
    }

    await db.chats.insertOne(ChatInsertRequest(
        name: request.name,
        authorId: id.toString(),
        memberId: request.memberId));
    return ResponseDto(message: "Чат успешно создан");
  }

  @override
  Future<ResponseDto> deleteChat(ServiceCall call, ChatDto request) async {
    final authorId = Utils.getIdFromMetadata(call);
    final chatId = int.parse(request.id);
    if (chatId.isNaN) throw GrpcError.invalidArgument("Чат не найден");
    final chat = await db.chats.queryShortView(chatId);
    if (chat == null) throw GrpcError.notFound("Чат не найден");
    if (chat.authorId == authorId.toString()) {
      await db.chats.deleteOne(chatId);
      return ResponseDto(message: "Успешно удален");
    } else {
      throw GrpcError.permissionDenied('Нету доступа к чату');
    }
  }

  @override
  Future<ResponseDto> deleteMessage(
      ServiceCall call, MessageDto request) async {
    final chatId = request.chatId;

    if (chatId.isEmpty) throw GrpcError.notFound("ID чата не найден");
    return ResponseDto(message: "chatId");
  }

  @override
  Stream<MessageDto> listenChat(ServiceCall call, ChatDto request) async* {
    if (request.id.isEmpty) {
      throw GrpcError.invalidArgument("Чат не найден");
    }
    yield* streamController.stream.where((event) => event.chatId == request.id);
  }

  @override
  Future<ResponseDto> sendMessage(ServiceCall call, MessageDto request) async {
    //final chatId = call.clientMetadata?["chat_id"] ?? " ";
    final chatId = request.chatId;
    if (chatId.isEmpty) throw GrpcError.notFound("Id чата не найден");
    final authorId = Utils.getIdFromMetadata(call);
    final body = request.body;
    if (body.isEmpty) throw GrpcError.notFound("тело сообщения не найден");
    final id = await db.messages.insertOne(MessageInsertRequest(
        body: body, chatId: int.parse(chatId), authorId: authorId.toString()));
    streamController.add(request.deepCopy()
      ..authorId = authorId.toString()
      ..id = id.toString());
    return ResponseDto(message: "Успешно");
  }

  @override
  Future<ListChatsDto> fetchAllChats(
      ServiceCall call, RequestDto request) async {
    final id = Utils.getIdFromMetadata(call);

    final listChats = await db.chats.queryShortViews(
        QueryParams(where: "author_id='$id' OR member_id='$id'"));
    if (listChats.isEmpty) return ListChatsDto(chats: []);
    return await Isolate.run(() => Utils.parseChats(listChats));
  }

  @override
  Future<ChatDto> fetchChat(ServiceCall call, ChatDto request) async {
    final chatId = int.parse(request.id);
    if (chatId.isNaN) throw GrpcError.notFound("Чат не найден");
    final chat = await db.chats.queryFullView(chatId);
    if (chat == null) throw GrpcError.notFound("Чат не найден");
    final authorId = Utils.getIdFromMetadata(call);
    if (chat.authorId == authorId.toString() ||
        chat.memberId == authorId.toString()) {
      return await Isolate.run(() => Utils.parseChat(chat));
    } else {
      throw GrpcError.permissionDenied("Доступ запрещен");
    }
  }
}
