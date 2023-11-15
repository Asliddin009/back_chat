//
//  Generated code. Do not modify.
//  source: chats.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RequestDto extends $pb.GeneratedMessage {
  factory RequestDto() => create();
  RequestDto._() : super();
  factory RequestDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestDto', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestDto clone() => RequestDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestDto copyWith(void Function(RequestDto) updates) => super.copyWith((message) => updates(message as RequestDto)) as RequestDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestDto create() => RequestDto._();
  RequestDto createEmptyInstance() => create();
  static $pb.PbList<RequestDto> createRepeated() => $pb.PbList<RequestDto>();
  @$core.pragma('dart2js:noInline')
  static RequestDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestDto>(create);
  static RequestDto? _defaultInstance;
}

class ListChatsDto extends $pb.GeneratedMessage {
  factory ListChatsDto({
    $core.Iterable<ChatDto>? chats,
  }) {
    final $result = create();
    if (chats != null) {
      $result.chats.addAll(chats);
    }
    return $result;
  }
  ListChatsDto._() : super();
  factory ListChatsDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListChatsDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListChatsDto', createEmptyInstance: create)
    ..pc<ChatDto>(1, _omitFieldNames ? '' : 'chats', $pb.PbFieldType.PM, subBuilder: ChatDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListChatsDto clone() => ListChatsDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListChatsDto copyWith(void Function(ListChatsDto) updates) => super.copyWith((message) => updates(message as ListChatsDto)) as ListChatsDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListChatsDto create() => ListChatsDto._();
  ListChatsDto createEmptyInstance() => create();
  static $pb.PbList<ListChatsDto> createRepeated() => $pb.PbList<ListChatsDto>();
  @$core.pragma('dart2js:noInline')
  static ListChatsDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListChatsDto>(create);
  static ListChatsDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ChatDto> get chats => $_getList(0);
}

class ChatDto extends $pb.GeneratedMessage {
  factory ChatDto({
    $core.String? id,
    $core.String? name,
    $core.String? authorId,
    $core.Iterable<MessageDto>? messages,
    $core.String? memberId,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (authorId != null) {
      $result.authorId = authorId;
    }
    if (messages != null) {
      $result.messages.addAll(messages);
    }
    if (memberId != null) {
      $result.memberId = memberId;
    }
    return $result;
  }
  ChatDto._() : super();
  factory ChatDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChatDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChatDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'authorId')
    ..pc<MessageDto>(4, _omitFieldNames ? '' : 'messages', $pb.PbFieldType.PM, subBuilder: MessageDto.create)
    ..aOS(5, _omitFieldNames ? '' : 'memberId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChatDto clone() => ChatDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChatDto copyWith(void Function(ChatDto) updates) => super.copyWith((message) => updates(message as ChatDto)) as ChatDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChatDto create() => ChatDto._();
  ChatDto createEmptyInstance() => create();
  static $pb.PbList<ChatDto> createRepeated() => $pb.PbList<ChatDto>();
  @$core.pragma('dart2js:noInline')
  static ChatDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatDto>(create);
  static ChatDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get authorId => $_getSZ(2);
  @$pb.TagNumber(3)
  set authorId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorId() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<MessageDto> get messages => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get memberId => $_getSZ(4);
  @$pb.TagNumber(5)
  set memberId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMemberId() => $_has(4);
  @$pb.TagNumber(5)
  void clearMemberId() => clearField(5);
}

class MessageDto extends $pb.GeneratedMessage {
  factory MessageDto({
    $core.String? id,
    $core.String? body,
    $core.String? authorId,
    $core.String? chatId,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (body != null) {
      $result.body = body;
    }
    if (authorId != null) {
      $result.authorId = authorId;
    }
    if (chatId != null) {
      $result.chatId = chatId;
    }
    return $result;
  }
  MessageDto._() : super();
  factory MessageDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MessageDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MessageDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'body')
    ..aOS(3, _omitFieldNames ? '' : 'authorId')
    ..aOS(4, _omitFieldNames ? '' : 'chatId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MessageDto clone() => MessageDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MessageDto copyWith(void Function(MessageDto) updates) => super.copyWith((message) => updates(message as MessageDto)) as MessageDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MessageDto create() => MessageDto._();
  MessageDto createEmptyInstance() => create();
  static $pb.PbList<MessageDto> createRepeated() => $pb.PbList<MessageDto>();
  @$core.pragma('dart2js:noInline')
  static MessageDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageDto>(create);
  static MessageDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get body => $_getSZ(1);
  @$pb.TagNumber(2)
  set body($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBody() => $_has(1);
  @$pb.TagNumber(2)
  void clearBody() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get authorId => $_getSZ(2);
  @$pb.TagNumber(3)
  set authorId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get chatId => $_getSZ(3);
  @$pb.TagNumber(4)
  set chatId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChatId() => $_has(3);
  @$pb.TagNumber(4)
  void clearChatId() => clearField(4);
}

class ResponseDto extends $pb.GeneratedMessage {
  factory ResponseDto({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ResponseDto._() : super();
  factory ResponseDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResponseDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResponseDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResponseDto clone() => ResponseDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResponseDto copyWith(void Function(ResponseDto) updates) => super.copyWith((message) => updates(message as ResponseDto)) as ResponseDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResponseDto create() => ResponseDto._();
  ResponseDto createEmptyInstance() => create();
  static $pb.PbList<ResponseDto> createRepeated() => $pb.PbList<ResponseDto>();
  @$core.pragma('dart2js:noInline')
  static ResponseDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResponseDto>(create);
  static ResponseDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
