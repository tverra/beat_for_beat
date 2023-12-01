import 'dart:convert';

import 'package:beat_for_beat/database/data_parser.dart';
import 'package:beat_for_beat/database/db_repo.dart' as db_repo;
import 'package:beat_for_beat/extensions/extensions.dart';

class Team {
  Team({
    this.key,
    String? name,
    DateTime? created,
    DateTime? updated,
    int? contestKey,
  })  : _name = name,
        _created = created,
        _updated = updated,
        _contestKey = contestKey;

  factory Team.fromJson(String json, {required int key}) {
    final Map<String, dynamic> decoded =
        jsonDecode(json) as Map<String, dynamic>;

    return Team(
      key: tryParseInt(decoded['key']) ?? key,
      name: tryParseString(decoded['name']),
      created: tryParseDateTime(decoded['created']),
      updated: tryParseDateTime(decoded['updated']),
      contestKey: tryParseInt(decoded['contest_key']),
    );
  }

  int? key;
  String? _name;
  DateTime? _created;
  DateTime? _updated;
  int? _contestKey;

  String? get name => _name;

  DateTime? get created => _created;

  DateTime? get updated => _updated;

  int? get contestKey => _contestKey;

  String toJson() {
    final Map<String, dynamic> serialized = <String, dynamic>{
      'key': serializeInt(key),
      'name': serializeString(_name),
      'created': serializeDateTime(_created),
      'updated': serializeDateTime(_updated),
      'contest_key': serializeInt(_contestKey),
    };

    return jsonEncode(serialized);
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
