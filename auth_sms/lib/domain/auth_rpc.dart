import 'package:auth/generated/auth_sms.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class AuthSmsRpc extends AuthRpcServiceBase {
  @override
  Future<SmsResponseDto> authSms(ServiceCall call, SmsRequestDto request) {
    return Future.value(SmsResponseDto(sms: '0000'));
  }
}
