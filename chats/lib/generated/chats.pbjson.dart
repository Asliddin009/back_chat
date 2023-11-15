//
//  Generated code. Do not modify.
//  source: chats.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use requestDtoDescriptor instead')
const RequestDto$json = {
  '1': 'RequestDto',
};

/// Descriptor for `RequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDtoDescriptor = $convert.base64Decode(
    'CgpSZXF1ZXN0RHRv');

@$core.Deprecated('Use listChatsDtoDescriptor instead')
const ListChatsDto$json = {
  '1': 'ListChatsDto',
  '2': [
    {'1': 'chats', '3': 1, '4': 3, '5': 11, '6': '.ChatDto', '10': 'chats'},
  ],
};

/// Descriptor for `ListChatsDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listChatsDtoDescriptor = $convert.base64Decode(
    'CgxMaXN0Q2hhdHNEdG8SHgoFY2hhdHMYASADKAsyCC5DaGF0RHRvUgVjaGF0cw==');

@$core.Deprecated('Use chatDtoDescriptor instead')
const ChatDto$json = {
  '1': 'ChatDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'author_id', '3': 3, '4': 1, '5': 9, '10': 'authorId'},
    {'1': 'messages', '3': 4, '4': 3, '5': 11, '6': '.MessageDto', '10': 'messages'},
    {'1': 'member_id', '3': 5, '4': 1, '5': 9, '10': 'memberId'},
  ],
};

/// Descriptor for `ChatDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDtoDescriptor = $convert.base64Decode(
    'CgdDaGF0RHRvEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhsKCWF1dGhvcl'
    '9pZBgDIAEoCVIIYXV0aG9ySWQSJwoIbWVzc2FnZXMYBCADKAsyCy5NZXNzYWdlRHRvUghtZXNz'
    'YWdlcxIbCgltZW1iZXJfaWQYBSABKAlSCG1lbWJlcklk');

@$core.Deprecated('Use messageDtoDescriptor instead')
const MessageDto$json = {
  '1': 'MessageDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'body', '3': 2, '4': 1, '5': 9, '10': 'body'},
    {'1': 'author_id', '3': 3, '4': 1, '5': 9, '10': 'authorId'},
    {'1': 'chat_id', '3': 4, '4': 1, '5': 9, '10': 'chatId'},
  ],
};

/// Descriptor for `MessageDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDtoDescriptor = $convert.base64Decode(
    'CgpNZXNzYWdlRHRvEg4KAmlkGAEgASgJUgJpZBISCgRib2R5GAIgASgJUgRib2R5EhsKCWF1dG'
    'hvcl9pZBgDIAEoCVIIYXV0aG9ySWQSFwoHY2hhdF9pZBgEIAEoCVIGY2hhdElk');

@$core.Deprecated('Use responseDtoDescriptor instead')
const ResponseDto$json = {
  '1': 'ResponseDto',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResponseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDtoDescriptor = $convert.base64Decode(
    'CgtSZXNwb25zZUR0bxIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

