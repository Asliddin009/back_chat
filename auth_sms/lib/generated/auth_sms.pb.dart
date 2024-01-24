//
//  Generated code. Do not modify.
//  source: auth_sms.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SmsRequestDto extends $pb.GeneratedMessage {
  factory SmsRequestDto({
    $core.String? phone,
  }) {
    final $result = create();
    if (phone != null) {
      $result.phone = phone;
    }
    return $result;
  }
  SmsRequestDto._() : super();
  factory SmsRequestDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsRequestDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SmsRequestDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsRequestDto clone() => SmsRequestDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsRequestDto copyWith(void Function(SmsRequestDto) updates) => super.copyWith((message) => updates(message as SmsRequestDto)) as SmsRequestDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsRequestDto create() => SmsRequestDto._();
  SmsRequestDto createEmptyInstance() => create();
  static $pb.PbList<SmsRequestDto> createRepeated() => $pb.PbList<SmsRequestDto>();
  @$core.pragma('dart2js:noInline')
  static SmsRequestDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsRequestDto>(create);
  static SmsRequestDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => clearField(1);
}

class SmsResponseDto extends $pb.GeneratedMessage {
  factory SmsResponseDto({
    $core.String? sms,
  }) {
    final $result = create();
    if (sms != null) {
      $result.sms = sms;
    }
    return $result;
  }
  SmsResponseDto._() : super();
  factory SmsResponseDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SmsResponseDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SmsResponseDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sms')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SmsResponseDto clone() => SmsResponseDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SmsResponseDto copyWith(void Function(SmsResponseDto) updates) => super.copyWith((message) => updates(message as SmsResponseDto)) as SmsResponseDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SmsResponseDto create() => SmsResponseDto._();
  SmsResponseDto createEmptyInstance() => create();
  static $pb.PbList<SmsResponseDto> createRepeated() => $pb.PbList<SmsResponseDto>();
  @$core.pragma('dart2js:noInline')
  static SmsResponseDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SmsResponseDto>(create);
  static SmsResponseDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sms => $_getSZ(0);
  @$pb.TagNumber(1)
  set sms($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSms() => $_has(0);
  @$pb.TagNumber(1)
  void clearSms() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
