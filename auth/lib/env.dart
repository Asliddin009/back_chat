import 'dart:io';

abstract class Env {
  static int port = int.parse(Platform.environment['PORT'] ?? '4300');
  static int portSms =
      int.parse(Platform.environment['AUTH_SMS_PORT'] ?? '4500');
  static String sk = Platform.environment['SK'] ?? "secret_key";
  static int accessTokenLife =
      int.parse(Platform.environment['ACCESS_TOKEN_LIFE'] ?? "100");
  static int refreshTokenLife =
      int.parse(Platform.environment['REFRESH_TOKEN_LIFE'] ?? "100");
  static int countSession =
      int.parse(Platform.environment['COUNT_SESSION'] ?? "3");
}

// abstract class Env {
//   static int port = int.parse(Platform.environment['PORT']!);
//   static int portSms = int.parse(Platform.environment['AUTH_SMS_PORT']!);
//   static String sk = Platform.environment['SK']!;
//   static int accessTokenLife =
//       int.parse(Platform.environment['ACCESS_TOKEN_LIFE']!);
//   static int refreshTokenLife =
//       int.parse(Platform.environment['REFRESH_TOKEN_LIFE']!);
//   static int countSession = int.parse(Platform.environment['COUNT_SESSION']!);
// }
