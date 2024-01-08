import 'dart:async';
import 'dart:developer';

import 'package:files/data/grpc_intercetors.dart';
import 'package:files/env.dart';
import 'package:grpc/grpc.dart';

Future<void> startServer() async {
  runZonedGuarded(() async {
    final authServer = Server([
      //  FilesRpc()
    ], <Interceptor>[
      GrpcIntercetors.tokenInterceptor,
    ], CodecRegistry(codecs: [GzipCodec()]));
    await authServer.serve(port: Env.port);
    log("Сервер слушает порт: ${authServer.port}");
  }, (error, stack) {
    log("Error", error: error);
  });
}
