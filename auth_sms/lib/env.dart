import 'dart:io';

abstract class Env {
  static int port = int.parse(Platform.environment['PORT']!);
  static String emailSender = Platform.environment['EMAIL']!;
  static String passwordSender = Platform.environment['PASSWORD']!;
  static int codeLife = int.parse(Platform.environment['CODE_LIFE']!);
}
