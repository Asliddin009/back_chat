import 'package:auth/data/db.dart';

void ckeckDatabase() {
  if (db.connection().isClosed) {
    db = initDatabase();
  }
}
