import 'dart:math';

import 'package:auth/env.dart';
import 'package:auth/generated/auth_sms.pbgrpc.dart';
import 'package:auth/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AuthSmsRpc extends AuthSmsRpcServiceBase {
  @override
  Future<SmsResponseDto> authSms(
      ServiceCall call, SmsRequestDto request) async {
    try {
      var rng = Random();
      final code = rng.nextInt(8999) + 1000;
      final emailAsliddin = Env.emailSender;
      final password = Env.passwordSender;
      final email = request.email;
      final codeLifeData = Utils.convertDateTimeToString(
          DateTime.now().add(Duration(seconds: Env.codeLife)));
      final smtpServer = gmail(emailAsliddin, password);
      final message = Message()
        ..from = emailAsliddin
        ..recipients = [email]
        ..subject = 'Ваш код: $code'
        ..text = 'ваш код актуален до $codeLifeData';

      await send(message, smtpServer);
      return Future.value(
          SmsResponseDto(sms: code.toString(), smsLifeDate: codeLifeData));
    } on MailerException catch (error) {
      throw GrpcError.internal("ошибка при отправке кода на почту: $error");
    } on Exception catch (error) {
      throw GrpcError.internal("ошибка в методе authSms: $error");
    }
  }
}
