import 'package:beat_for_beat/database/db_repo.dart' as db_repo;
import 'package:beat_for_beat/extensions/extensions.dart';
import 'package:beat_for_beat/models/contest.dart';
import 'package:beat_for_beat/models/team.dart';
import 'package:flutter/material.dart';

class TeamsBuilder extends StatefulWidget {
  const TeamsBuilder({
    super.key,
    required this.contest,
    required this.builder,
    required this.onError,
  });

  final Contest contest;
  final Widget Function(BuildContext context, List<Team>? teams) builder;
  final void Function(BuildContext context, String errorMessage) onError;

  @override
  State<TeamsBuilder> createState() => _TeamsBuilderState();
}

class _TeamsBuilderState extends State<TeamsBuilder> {
  Future<List<Team>>? _teamsFuture;

  @override
  void initState() {
    super.initState();

    final int? contestKey = widget.contest.key;

    if (contestKey != null) {
      _teamsFuture = db_repo.getTeams(contestKey: contestKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Team>?>(
      future: _teamsFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Team>?> snapshot) {
        final List<Team>? teams = snapshot.data;

        if (snapshot.hasError ||
            _teamsFuture == null ||
            (snapshot.isDone && !snapshot.hasData)) {
          late final String errorMessage;

          if (snapshot.hasError) {
            errorMessage = snapshot.error.toString();
          } else if (snapshot.data?.isEmpty ?? true) {
            errorMessage = 'Could not find any teams with contest_key: '
                "'${widget.contest.key}'";
          } else {
            errorMessage = 'Error: could not load teams';
          }

          widget.onError(context, errorMessage);
        }

        return widget.builder(context, teams);
      },
    );
  }
}
