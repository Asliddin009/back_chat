import 'dart:async';
import 'dart:developer';

import 'package:chats/data/db.dart';
import 'package:chats/data/grpc_intercetors.dart';
import 'package:chats/env.dart';
import 'package:grpc/grpc.dart';

Future<void> startServer() async {
  runZonedGuarded(() async {
    final authServer = Server([], <Interceptor>[
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
