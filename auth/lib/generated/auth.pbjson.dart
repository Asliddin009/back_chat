//
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use listUserDtoDescriptor instead')
const ListUserDto$json = {
  '1': 'ListUserDto',
  '2': [
    {'1': 'users', '3': 1, '4': 3, '5': 11, '6': '.UserDto', '10': 'users'},
  ],
};

/// Descriptor for `ListUserDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUserDtoDescriptor = $convert.base64Decode(
    'CgtMaXN0VXNlckR0bxIeCgV1c2VycxgBIAMoCzIILlVzZXJEdG9SBXVzZXJz');

@$core.Deprecated('Use findDtoDescriptor instead')
const FindDto$json = {
  '1': 'FindDto',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'limit', '3': 2, '4': 1, '5': 9, '10': 'limit'},
    {'1': 'offset', '3': 3, '4': 1, '5': 9, '10': 'offset'},
  ],
};

/// Descriptor for `FindDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List findDtoDescriptor = $convert.base64Decode(
    'CgdGaW5kRHRvEhAKA2tleRgBIAEoCVIDa2V5EhQKBWxpbWl0GAIgASgJUgVsaW1pdBIWCgZvZm'
    'ZzZXQYAyABKAlSBm9mZnNldA==');

@$core.Deprecated('Use roleDtoDescriptor instead')
const RoleDto$json = {
  '1': 'RoleDto',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'role_name', '3': 2, '4': 1, '5': 9, '10': 'roleName'},
    {'1': 'is_read', '3': 3, '4': 1, '5': 8, '10': 'isRead'},
    {'1': 'is_create', '3': 4, '4': 1, '5': 8, '10': 'isCreate'},
    {'1': 'is_update', '3': 5, '4': 1, '5': 8, '10': 'isUpdate'},
    {'1': 'is_delete', '3': 6, '4': 1, '5': 8, '10': 'isDelete'},
  ],
};

/// Descriptor for `RoleDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roleDtoDescriptor = $convert.base64Decode(
    'CgdSb2xlRHRvEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCglyb2xlX25hbWUYAiABKAlSCH'
    'JvbGVOYW1lEhcKB2lzX3JlYWQYAyABKAhSBmlzUmVhZBIbCglpc19jcmVhdGUYBCABKAhSCGlz'
    'Q3JlYXRlEhsKCWlzX3VwZGF0ZRgFIAEoCFIIaXNVcGRhdGUSGwoJaXNfZGVsZXRlGAYgASgIUg'
    'hpc0RlbGV0ZQ==');

@$core.Deprecated('Use userDtoDescriptor instead')
const UserDto$json = {
  '1': 'UserDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'password', '3': 4, '4': 1, '5': 9, '9': 0, '10': 'password'},
  ],
  '8': [
    {'1': 'optional_password'},
  ],
};

/// Descriptor for `UserDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDtoDescriptor = $convert.base64Decode(
    'CgdVc2VyRHRvEg4KAmlkGAEgASgJUgJpZBIaCgh1c2VybmFtZRgCIAEoCVIIdXNlcm5hbWUSFA'
    'oFZW1haWwYAyABKAlSBWVtYWlsEhwKCHBhc3N3b3JkGAQgASgJSABSCHBhc3N3b3JkQhMKEW9w'
    'dGlvbmFsX3Bhc3N3b3Jk');

@$core.Deprecated('Use tokensDtoDescriptor instead')
const TokensDto$json = {
  '1': 'TokensDto',
  '2': [
    {'1': 'access_token', '3': 1, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `TokensDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokensDtoDescriptor = $convert.base64Decode(
    'CglUb2tlbnNEdG8SIQoMYWNjZXNzX3Rva2VuGAEgASgJUgthY2Nlc3NUb2tlbhIjCg1yZWZyZX'
    'NoX3Rva2VuGAIgASgJUgxyZWZyZXNoVG9rZW4=');

@$core.Deprecated('Use requestDtoDescriptor instead')
const RequestDto$json = {
  '1': 'RequestDto',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `RequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDtoDescriptor = $convert.base64Decode(
    'CgpSZXF1ZXN0RHRvEhQKBWVtYWlsGAEgASgJUgVlbWFpbBISCgRjb2RlGAIgASgJUgRjb2Rl');

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

