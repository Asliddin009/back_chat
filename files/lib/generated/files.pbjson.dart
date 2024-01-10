//
//  Generated code. Do not modify.
//  source: files.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use fileDtoDescriptor instead')
const FileDto$json = {
  '1': 'FileDto',
  '2': [
    {'1': 'data', '3': 1, '4': 1, '5': 12, '10': 'data'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'bucket', '3': 3, '4': 1, '5': 9, '10': 'bucket'},
    {'1': 'tag', '3': 4, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `FileDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileDtoDescriptor = $convert.base64Decode(
    'CgdGaWxlRHRvEhIKBGRhdGEYASABKAxSBGRhdGESEgoEbmFtZRgCIAEoCVIEbmFtZRIWCgZidW'
    'NrZXQYAyABKAlSBmJ1Y2tldBIQCgN0YWcYBCABKAlSA3RhZw==');

@$core.Deprecated('Use responseDtoDescriptor instead')
const ResponseDto$json = {
  '1': 'ResponseDto',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'is_complete', '3': 2, '4': 1, '5': 8, '10': 'isComplete'},
    {'1': 'tag', '3': 3, '4': 1, '5': 9, '10': 'tag'},
  ],
};

/// Descriptor for `ResponseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDtoDescriptor = $convert.base64Decode(
    'CgtSZXNwb25zZUR0bxIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdlEh8KC2lzX2NvbXBsZXRlGA'
    'IgASgIUgppc0NvbXBsZXRlEhAKA3RhZxgDIAEoCVIDdGFn');

