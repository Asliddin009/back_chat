//
//  Generated code. Do not modify.
//  source: auth_sms.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use smsRequestDtoDescriptor instead')
const SmsRequestDto$json = {
  '1': 'SmsRequestDto',
  '2': [
    {'1': 'email', '3': 1, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `SmsRequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsRequestDtoDescriptor = $convert.base64Decode(
    'Cg1TbXNSZXF1ZXN0RHRvEhQKBWVtYWlsGAEgASgJUgVlbWFpbA==');

@$core.Deprecated('Use smsResponseDtoDescriptor instead')
const SmsResponseDto$json = {
  '1': 'SmsResponseDto',
  '2': [
    {'1': 'sms', '3': 1, '4': 1, '5': 9, '10': 'sms'},
    {'1': 'sms_life_date', '3': 2, '4': 1, '5': 9, '10': 'smsLifeDate'},
  ],
};

/// Descriptor for `SmsResponseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List smsResponseDtoDescriptor = $convert.base64Decode(
    'Cg5TbXNSZXNwb25zZUR0bxIQCgNzbXMYASABKAlSA3NtcxIiCg1zbXNfbGlmZV9kYXRlGAIgAS'
    'gJUgtzbXNMaWZlRGF0ZQ==');

