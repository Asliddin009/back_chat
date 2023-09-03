import 'dart:io';

abstract class Env {
  static int port = int.parse(Platform.environment['PORT']!);
  static String sk = Platform.environment['SK']!;
  static int accessTokenLife =
      int.parse(Platform.environment['ACCESS_TOKEN_LIFE']!);
  static int refreshTokenLife =
      int.parse(Platform.environment['REFRESH_TOKEN_LIFE']!);
}
