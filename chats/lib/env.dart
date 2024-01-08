import 'dart:io';

abstract class Env {
  static int port = int.parse(Platform.environment['PORT']!);
  static String sk = Platform.environment['SK']!;
}
