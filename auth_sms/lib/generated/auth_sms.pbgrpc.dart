//
//  Generated code. Do not modify.
//  source: auth_sms.proto
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

import 'auth_sms.pb.dart' as $0;

export 'auth_sms.pb.dart';

@$pb.GrpcServiceName('AuthSmsRpc')
class AuthSmsRpcClient extends $grpc.Client {
  static final _$authSms = $grpc.ClientMethod<$0.SmsRequestDto, $0.SmsResponseDto>(
      '/AuthSmsRpc/AuthSms',
      ($0.SmsRequestDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SmsResponseDto.fromBuffer(value));

  AuthSmsRpcClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.SmsResponseDto> authSms($0.SmsRequestDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$authSms, request, options: options);
  }
}

@$pb.GrpcServiceName('AuthSmsRpc')
abstract class AuthSmsRpcServiceBase extends $grpc.Service {
  $core.String get $name => 'AuthSmsRpc';

  AuthSmsRpcServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SmsRequestDto, $0.SmsResponseDto>(
        'AuthSms',
        authSms_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SmsRequestDto.fromBuffer(value),
        ($0.SmsResponseDto value) => value.writeToBuffer()));
  }

  $async.Future<$0.SmsResponseDto> authSms_Pre($grpc.ServiceCall call, $async.Future<$0.SmsRequestDto> request) async {
    return authSms(call, await request);
  }

  $async.Future<$0.SmsResponseDto> authSms($grpc.ServiceCall call, $0.SmsRequestDto request);
}
