import 'dart:async';

import 'package:auth/data/db.dart';
import 'package:auth/data/intercetors/log_intercetors.dart';
import 'package:auth/data/intercetors/token_intercetors.dart';
import 'package:auth/data/net_repo.dart';
import 'package:auth/domain/auth_rpc.dart';
import 'package:auth/env.dart';
import 'package:grpc/grpc.dart';

Future<void> startServer() async {
  runZonedGuarded(() async {
    final authServer = Server.create(services: [
      AuthRpc(NetRepo())
    ], interceptors: <Interceptor>[
      TokenIntercetors.tokenInterceptor,
      LogIntercetors.logInterceptor
    ], codecRegistry: CodecRegistry(codecs: [GzipCodec()]));
    await authServer.serve(port: Env.port);
    print("Сервер слушает порт: ${authServer.port}");
    db = initDatabase();
    db.open();
    //AuthIsolate.startIsolate();
  }, (error, stack) {
    print("Error: $error");
  });
}
