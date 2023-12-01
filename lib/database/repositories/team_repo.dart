import 'package:beat_for_beat/database/database.dart';
import 'package:beat_for_beat/extensions/extensions.dart';
import 'package:beat_for_beat/models/team.dart';
import 'package:idb_sqflite/idb_sqflite.dart';

Future<int> insertTeam(Team team) async {
  final Database db = await DbProvider.db.getDatabase();
  final Transaction txn = db.transaction('team', idbModeReadWrite);
  final ObjectStore store = txn.objectStore('team');

  final Object key = await store.put(team.toMap());
  await txn.completed;

  return key as int;
}

Future<Team?> getTeam(int key) async {
  final Database db = await DbProvider.db.getDatabase();
  final Transaction txn = db.transaction('team', idbModeReadOnly);
  final ObjectStore store = txn.objectStore('team');

  final Object? value = await store.getObject(key);
  await txn.completed;

  return value != null ? Team.fromJson(value.castIdbResult()) : null;
}

Future<List<Team>> getTeams({int? contestKey}) async {
  final Database db = await DbProvider.db.getDatabase();
  final Transaction txn = db.transaction('team', idbModeReadOnly);
  final ObjectStore store = txn.objectStore('team');

  final Stream<CursorWithValue> cursor = store.openCursor(autoAdvance: true);
  final List<Team> matches = <Team>[];

  await cursor.listen((CursorWithValue event) {
    final Team team =
        Team.fromJson(event.value.castIdbResult(), key: event.key as int);

    if (contestKey == null || team.contestKey == contestKey) {
      matches.add(team);
    }
  }).asFuture<void>();

  await txn.completed;

  return matches;
}

Future<Team?> updateTeam(Team team) async {
  if (team.key == null) {
    return null;
  }

  final int key = await insertTeam(team);
  team.key = key;

  return team;
}

Future<Team> upsertTeam(Team team) async {
  final int key = await insertTeam(team);
  team.key = key;

  return team;
}
