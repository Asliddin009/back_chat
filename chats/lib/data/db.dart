import 'package:stormberry/stormberry.dart';

late Database db;

Database initDatabase() => Database(
      host: '127.0.0.1',
      port: 4301,
      useSSL: false,
      user: 'asli',
      password: 'asli',
    );
