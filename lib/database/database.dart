import 'dart:async';

import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class DbProvider {
  DbProvider._();

  static final DbProvider db = DbProvider._();
  static const String _databaseName = 'beat_for_beat.db';
  static Database? _database;
  Future<dynamic>? _initInProgress;

  Future<Database> _initDB() async {
    final IdbFactory factory = getIdbFactorySqflite(sqflite.databaseFactory);
    final Database db = await factory.open(
      _databaseName,
      version: 1,
      onUpgradeNeeded: (VersionChangeEvent event) {
        event.database
          ..createObjectStore('contest', keyPath: 'key', autoIncrement: true)
          ..createObjectStore('team', keyPath: 'key', autoIncrement: true);
      },
    );
    return db;
  }

  Future<Database> getDatabase() async {
    final Database? db = _database;

    if (db != null) {
      return db;
    }

    if (_initInProgress != null) {
      await _initInProgress;
      return getDatabase();
    }

    final Completer<dynamic> completer = Completer<dynamic>();
    _initInProgress = completer.future;

    final Database database = _database = await _initDB();

    completer.complete();
    _initInProgress = null;

    return database;
  }

  Future<void> closeDatabase() async {
    final Database? db = _database;

    if (db == null) {
      return;
    }

    db.close();
    _database = null;
  }
}
