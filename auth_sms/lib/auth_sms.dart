import 'dart:async';
import 'dart:developer';
import 'package:auth/domain/auth_rpc.dart';
import 'package:auth/env.dart';
import 'package:grpc/grpc.dart';

Future<void> startServer() async {
  runZonedGuarded(() async {
    final authSmsServer = Server.create(
        services: [AuthSmsRpc()],
        codecRegistry: CodecRegistry(codecs: [GzipCodec()]));
    await authSmsServer.serve(port: Env.port);
    log("Сервер слушает порт: ${authSmsServer.port}");
  }, (error, stack) {
    log("Error", error: error);
  });
}
