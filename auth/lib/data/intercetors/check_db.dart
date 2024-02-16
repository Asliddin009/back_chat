import 'package:auth/data/db.dart';

void ckeckDatabase() {
  if (db.connection().isClosed) {
    db = initDatabase();
  }
}

final excludeMethods = [
  'SignUp',
  'SignIn',
  'RefreshToken',
  'SendSms',
  'SignInSms'
];
