import 'dart:io';

abstract class Env {
  static int port = int.parse(Platform.environment['PORT'] ?? '4401');
  static String sk = Platform.environment['SK'] ?? 'secret_key';
}
