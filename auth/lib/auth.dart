import 'dart:async';
import 'dart:developer';

import 'package:auth/data/db.dart';
import 'package:auth/data/grpc_intercetors.dart';
import 'package:auth/domain/auth_rpc.dart';
import 'package:auth/env.dart';
import 'package:grpc/grpc.dart';

Future<void> startServer() async {
  runZonedGuarded(() async {
    final authServer = Server([
      AuthRpc()
    ], <Interceptor>[
      GrpcIntercetors.tokenInterceptor,
    ], CodecRegistry(codecs: [GzipCodec()]));
    await authServer.serve(port: Env.port);
    log("Сервер слушает порт: ${authServer.port}");
    db = initDatabase();
    db.open();
  }, (error, stack) {
    log("Error", error: error);
  });
}
