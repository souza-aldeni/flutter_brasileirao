import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_brasileirao/models/time.dart';
import 'package:flutter_application_brasileirao/repositories/times_repository.dart';

class DBDatabase {
  DBDatabase._();
  static final DBDatabase instance = DBDatabase._();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  get database async {
    final snapshot = await _database.get();
    if (snapshot.exists) {
      return _database;
    } else {
      return await _initDatabase();
    }
  }

  _initDatabase() async {
    await setupTimes(_database);
    return _database;
  }

  setupTimes(db) async {
    for (Time time in TimesRepository.setupTimes()) {
      var timeId = await db.child('BD/TIMES').push().key;
      await db.child('BD/TIMES/$timeId').update({
        "id": timeId,
        "nome": time.nome,
        "brasao": time.brasao,
        "pontos": time.pontos,
        "cor": time.cor.toString(),
      });
    }
  }
}
