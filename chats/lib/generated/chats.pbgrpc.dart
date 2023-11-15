//
//  Generated code. Do not modify.
//  source: chats.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'chats.pb.dart' as $0;

export 'chats.pb.dart';

@$pb.GrpcServiceName('ChatsRpc')
class ChatsRpcClient extends $grpc.Client {
  static final _$fetchAllChats = $grpc.ClientMethod<$0.RequestDto, $0.ListChatsDto>(
      '/ChatsRpc/FetchAllChats',
      ($0.RequestDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListChatsDto.fromBuffer(value));
  static final _$createChat = $grpc.ClientMethod<$0.ChatDto, $0.ResponseDto>(
      '/ChatsRpc/CreateChat',
      ($0.ChatDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteChat = $grpc.ClientMethod<$0.ChatDto, $0.ResponseDto>(
      '/ChatsRpc/DeleteChat',
      ($0.ChatDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$fetchChat = $grpc.ClientMethod<$0.ChatDto, $0.ChatDto>(
      '/ChatsRpc/FetchChat',
      ($0.ChatDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value));
  static final _$sendMessage = $grpc.ClientMethod<$0.MessageDto, $0.ResponseDto>(
      '/ChatsRpc/SendMessage',
      ($0.MessageDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteMessage = $grpc.ClientMethod<$0.MessageDto, $0.ResponseDto>(
      '/ChatsRpc/DeleteMessage',
      ($0.MessageDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$listenChat = $grpc.ClientMethod<$0.ChatDto, $0.MessageDto>(
      '/ChatsRpc/ListenChat',
      ($0.ChatDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MessageDto.fromBuffer(value));

  ChatsRpcClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ListChatsDto> fetchAllChats($0.RequestDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchAllChats, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> createChat($0.ChatDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createChat, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteChat($0.ChatDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteChat, request, options: options);
  }

  $grpc.ResponseFuture<$0.ChatDto> fetchChat($0.ChatDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchChat, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> sendMessage($0.MessageDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteMessage($0.MessageDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteMessage, request, options: options);
  }

  $grpc.ResponseStream<$0.MessageDto> listenChat($0.ChatDto request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$listenChat, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('ChatsRpc')
abstract class ChatsRpcServiceBase extends $grpc.Service {
  $core.String get $name => 'ChatsRpc';

  ChatsRpcServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.ListChatsDto>(
        'FetchAllChats',
        fetchAllChats_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.ListChatsDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.ResponseDto>(
        'CreateChat',
        createChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.ResponseDto>(
        'DeleteChat',
        deleteChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.ChatDto>(
        'FetchChat',
        fetchChat_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.ChatDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MessageDto, $0.ResponseDto>(
        'SendMessage',
        sendMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MessageDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MessageDto, $0.ResponseDto>(
        'DeleteMessage',
        deleteMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MessageDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChatDto, $0.MessageDto>(
        'ListenChat',
        listenChat_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.ChatDto.fromBuffer(value),
        ($0.MessageDto value) => value.writeToBuffer()));
  }

  $async.Future<$0.ListChatsDto> fetchAllChats_Pre($grpc.ServiceCall call, $async.Future<$0.RequestDto> request) async {
    return fetchAllChats(call, await request);
  }

  $async.Future<$0.ResponseDto> createChat_Pre($grpc.ServiceCall call, $async.Future<$0.ChatDto> request) async {
    return createChat(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteChat_Pre($grpc.ServiceCall call, $async.Future<$0.ChatDto> request) async {
    return deleteChat(call, await request);
  }

  $async.Future<$0.ChatDto> fetchChat_Pre($grpc.ServiceCall call, $async.Future<$0.ChatDto> request) async {
    return fetchChat(call, await request);
  }

  $async.Future<$0.ResponseDto> sendMessage_Pre($grpc.ServiceCall call, $async.Future<$0.MessageDto> request) async {
    return sendMessage(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteMessage_Pre($grpc.ServiceCall call, $async.Future<$0.MessageDto> request) async {
    return deleteMessage(call, await request);
  }

  $async.Stream<$0.MessageDto> listenChat_Pre($grpc.ServiceCall call, $async.Future<$0.ChatDto> request) async* {
    yield* listenChat(call, await request);
  }

  $async.Future<$0.ListChatsDto> fetchAllChats($grpc.ServiceCall call, $0.RequestDto request);
  $async.Future<$0.ResponseDto> createChat($grpc.ServiceCall call, $0.ChatDto request);
  $async.Future<$0.ResponseDto> deleteChat($grpc.ServiceCall call, $0.ChatDto request);
  $async.Future<$0.ChatDto> fetchChat($grpc.ServiceCall call, $0.ChatDto request);
  $async.Future<$0.ResponseDto> sendMessage($grpc.ServiceCall call, $0.MessageDto request);
  $async.Future<$0.ResponseDto> deleteMessage($grpc.ServiceCall call, $0.MessageDto request);
  $async.Stream<$0.MessageDto> listenChat($grpc.ServiceCall call, $0.ChatDto request);
}
