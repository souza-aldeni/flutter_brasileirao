import 'package:flutter_application_brasileirao/repositories/times_repository.dart';
import '../models/time.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  get database async {
    if (_database != null) return _database;
    return await _initDatabase();

  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'dados.db'),
      onCreate: (db, versao) async {
        await db.execute(times);
        await db.execute(titulos);
        await setupTimes(db);
      },
      version: 1,
    );
  }

  setupTimes(db) {
    for (Time time in TimesRepository.setupTimes()) {
      db.insert('times', {
        'nome': time.nome,
        'brasao': time.brasao,
        'pontos': time.pontos,
        'cor': time.cor.toString()
      });
    }
  }

  String get times => '''
    CREATE TABLE times(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    pontos INTEGER,
    brasao TEXT,
    cor TEXT
    );
    ''';

  String get titulos => '''
    CREATE TABLE titulos(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    campeonato TEXT,
    ano TEXT,
    time_id INTEGER,
    FOREIGN KEY (time_id) REFERENCES times(id) ON DELETE CASCADE
    );
    ''';
}
