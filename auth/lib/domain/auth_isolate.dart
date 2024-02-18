import 'dart:async';
import 'dart:isolate';
import 'package:auth/data/db.dart';
import 'package:auth/env.dart';

class AuthIsolate {
  void ckeckDatabase() {
    if (db.connection().isClosed) {
      db = initDatabase();
    }
  }

  AuthIsolate();
  void startIsolate() async {
    ckeckDatabase();
    await Isolate.spawn(authIsolate, Object());
  }

  void authIsolate(Object _) {
    Timer.periodic(Duration(minutes: 1), (_) async {
      print("количество сессий: ${Env.countSession}");
    });
  }
}
