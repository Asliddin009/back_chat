import 'dart:io';

abstract class Env {
  static int port = int.parse(Platform.environment['FILES_PORT']!);
  static String sk = Platform.environment['SK']!;
  static String accessKey = Platform.environment['FILES_ACCESS_KEY']!;
  static String secretKey = Platform.environment['FILES_SECRET_KEY']!;
  static bool storageUseSSL =
      bool.parse(Platform.environment['FILES_USE_SSL']!);
  static int storagePort =
      int.parse(Platform.environment['FILES_STORAGE_PORT']!);
  static String storageHost = Platform.environment['FILES_STORAGE_HOST']!;
}
