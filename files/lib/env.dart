import 'dart:io';

abstract class Env {
  static int port = int.parse(Platform.environment['PORT']??'4402');
  static String sk = Platform.environment['SK']!;
}
