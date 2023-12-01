import 'package:beat_for_beat/database/data_parser.dart';
import 'package:beat_for_beat/database/db_repo.dart' as db_repo;
import 'package:beat_for_beat/extensions/extensions.dart';

class Contest {
  Contest({
    this.key,
    DateTime? created,
    DateTime? finished,
    DateTime? updated,
  })  : _created = created,
        _finished = finished,
        _updated = updated;

  factory Contest.fromMap(Map<String, dynamic> map, {int? key}) {
    return Contest(
      key: tryParseInt(map['key']) ?? key,
      created: tryParseDateTime(map['created']),
      finished: tryParseDateTime(map['finished']),
      updated: tryParseDateTime(map['updated']),
    );
  }

  int? key;
  DateTime? _created;
  DateTime? _finished;
  DateTime? _updated;

  DateTime? get created => _created;

  DateTime? get finished => _finished;

  DateTime? get updated => _updated;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': serializeInt(key),
      'created': serializeDateTime(_created),
      'finished': serializeDateTime(_finished),
      'updated': serializeDateTime(_updated),
    };
  }

  Future<bool> save() async {
    final DateTime timestamp = DateTime.now();
    _created ??= timestamp;
    _updated = timestamp;

    final Contest result = await db_repo.upsertContest(this);
    key ??= result.key;

    return result.key == key;
  }

  @override
  String toString() {
    return 'Contest(key: $key, updated: ${updated?.format()})';
  }
}
