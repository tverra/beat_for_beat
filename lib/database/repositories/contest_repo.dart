import 'package:beat_for_beat/database/database.dart';
import 'package:beat_for_beat/extensions/extensions.dart';
import 'package:beat_for_beat/models/contest.dart';
import 'package:idb_sqflite/idb_sqflite.dart';

Future<int> insertContest(Contest contest) async {
  final Database db = await DbProvider.db.getDatabase();
  final Transaction txn = db.transaction('contest', idbModeReadWrite);
  final ObjectStore store = txn.objectStore('contest');

  final Object key = await store.put(contest.toMap());
  await txn.completed;

  return key as int;
}

Future<Contest?> getContest(int key) async {
  final Database db = await DbProvider.db.getDatabase();
  final Transaction txn = db.transaction('contest', idbModeReadOnly);
  final ObjectStore store = txn.objectStore('contest');

  final Object? value = await store.getObject(key);
  await txn.completed;

  return value != null ? Contest.fromMap(value.castIdbResult()) : null;
}

Future<List<Contest>> getContests({bool? finished}) async {
  final Database db = await DbProvider.db.getDatabase();
  final Transaction txn = db.transaction('contest', idbModeReadOnly);
  final ObjectStore store = txn.objectStore('contest');

  final Stream<CursorWithValue> cursor = store.openCursor(autoAdvance: true);
  final List<Contest> matches = <Contest>[];

  await cursor.listen((CursorWithValue event) {
    final Contest contest =
        Contest.fromMap(event.value.castIdbResult(), key: event.key as int);

    if (finished == null || (contest.finished != null) == finished) {
      matches.add(contest);
    }
  }).asFuture<void>();

  await txn.completed;

  return matches;
}

Future<Contest?> updateContest(Contest contest) async {
  if (contest.key == null) {
    return null;
  }

  final int key = await insertContest(contest);
  contest.key = key;

  return contest;
}

Future<Contest> upsertContest(Contest contest) async {
  final int key = await insertContest(contest);
  contest.key = key;

  return contest;
}
