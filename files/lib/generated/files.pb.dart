//
//  Generated code. Do not modify.
//  source: files.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FileDto extends $pb.GeneratedMessage {
  factory FileDto({
    $core.List<$core.int>? data,
    $core.String? name,
    $core.String? bucket,
    $core.String? tag,
  }) {
    final $result = create();
    if (data != null) {
      $result.data = data;
    }
    if (name != null) {
      $result.name = name;
    }
    if (bucket != null) {
      $result.bucket = bucket;
    }
    if (tag != null) {
      $result.tag = tag;
    }
    return $result;
  }
  FileDto._() : super();
  factory FileDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FileDto', createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'bucket')
    ..aOS(4, _omitFieldNames ? '' : 'tag')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileDto clone() => FileDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileDto copyWith(void Function(FileDto) updates) => super.copyWith((message) => updates(message as FileDto)) as FileDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileDto create() => FileDto._();
  FileDto createEmptyInstance() => create();
  static $pb.PbList<FileDto> createRepeated() => $pb.PbList<FileDto>();
  @$core.pragma('dart2js:noInline')
  static FileDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileDto>(create);
  static FileDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get bucket => $_getSZ(2);
  @$pb.TagNumber(3)
  set bucket($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBucket() => $_has(2);
  @$pb.TagNumber(3)
  void clearBucket() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get tag => $_getSZ(3);
  @$pb.TagNumber(4)
  set tag($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTag() => $_has(3);
  @$pb.TagNumber(4)
  void clearTag() => clearField(4);
}

class ResponseDto extends $pb.GeneratedMessage {
  factory ResponseDto({
    $core.String? message,
    $core.bool? isComplete,
    $core.String? tag,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (isComplete != null) {
      $result.isComplete = isComplete;
    }
    if (tag != null) {
      $result.tag = tag;
    }
    return $result;
  }
  ResponseDto._() : super();
  factory ResponseDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResponseDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResponseDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOB(2, _omitFieldNames ? '' : 'isComplete')
    ..aOS(3, _omitFieldNames ? '' : 'tag')
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

  @$pb.TagNumber(2)
  $core.bool get isComplete => $_getBF(1);
  @$pb.TagNumber(2)
  set isComplete($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsComplete() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsComplete() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get tag => $_getSZ(2);
  @$pb.TagNumber(3)
  set tag($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTag() => $_has(2);
  @$pb.TagNumber(3)
  void clearTag() => clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
