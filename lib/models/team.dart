import 'package:beat_for_beat/database/data_parser.dart';
import 'package:beat_for_beat/database/db_repo.dart' as db_repo;
import 'package:beat_for_beat/extensions/extensions.dart';

class Team {
  Team({
    this.key,
    String? name,
    int? points,
    DateTime? created,
    DateTime? updated,
    int? contestKey,
  })  : _name = name,
        _points = points,
        _created = created,
        _updated = updated,
        _contestKey = contestKey;

  factory Team.fromJson(Map<String, dynamic> map, {int? key}) {
    return Team(
      key: tryParseInt(map['key']) ?? key,
      name: tryParseString(map['name']),
      points: tryParseInt(map['points']),
      created: tryParseDateTime(map['created']),
      updated: tryParseDateTime(map['updated']),
      contestKey: tryParseInt(map['contest_key']),
    );
  }

  int? key;
  String? _name;
  int? _points;
  DateTime? _created;
  DateTime? _updated;
  int? _contestKey;

  String? get name => _name;

  int? get points => _points;

  DateTime? get created => _created;

  DateTime? get updated => _updated;

  int? get contestKey => _contestKey;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': serializeInt(key),
      'name': serializeString(_name),
      'points': serializeInt(_points),
      'created': serializeDateTime(_created),
      'updated': serializeDateTime(_updated),
      'contest_key': serializeInt(_contestKey),
    };
  }

  Future<bool> save() async {
    final DateTime timestamp = DateTime.now();
    _created ??= timestamp;
    _updated = timestamp;

    final Team result = await db_repo.upsertTeam(this);
    key ??= result.key;

    return result.key == key;
  }

  @override
  String toString() {
    return 'Team(key: $key, name: $name, updated: ${updated?.format()})';
  }
}
