import 'dart:async';
import 'dart:isolate';
import 'package:auth/data/db.dart';
import 'package:auth/data/entity/user/user.dart';
import 'package:auth/env.dart';

abstract class AuthIsolate {
  AuthIsolate();
  static void startIsolate() {
    Isolate.spawn(authIsolate, Object());
  }

  static void authIsolate(Object _) {
    Timer.periodic(Duration(seconds: 10), (_) async {
      final user = await db.users.queryUser(21);
      print("количество сессий: ${Env.countSession}");
      print("юзер: ${user?.username ?? " "}");
    });
  }
}
