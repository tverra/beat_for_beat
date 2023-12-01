import 'package:beat_for_beat/database/db_repo.dart' as db_repo;
import 'package:beat_for_beat/extensions/extensions.dart';
import 'package:beat_for_beat/models/contest.dart';
import 'package:flutter/material.dart';

class ContestBuilder extends StatefulWidget {
  const ContestBuilder({
    super.key,
    required this.contest,
    required this.builder,
    required this.onError,
  });

  final Contest contest;
  final Widget Function(BuildContext context, Contest contest) builder;
  final void Function(BuildContext context, String errorMessage) onError;

  @override
  State<ContestBuilder> createState() => _ContestBuilderState();
}

class _ContestBuilderState extends State<ContestBuilder> {
  Future<Contest?>? _contestFuture;

  @override
  void initState() {
    super.initState();

    final int? contestKey = widget.contest.key;

    if (contestKey != null) {
      _contestFuture = db_repo.getContest(contestKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Contest?>(
      future: _contestFuture,
      builder: (BuildContext context, AsyncSnapshot<Contest?> snapshot) {
        final Contest contest = snapshot.data ?? widget.contest;

        if (snapshot.hasError ||
            _contestFuture == null ||
            (snapshot.isDone && !snapshot.hasData)) {
          late final String errorMessage;

          if (snapshot.hasError) {
            errorMessage = snapshot.error.toString();
          } else if (!snapshot.hasData) {
            errorMessage =
                "Could not find contest with key: '${widget.contest.key}'";
          } else {
            errorMessage = 'Error: could not load contest';
          }

          widget.onError(context, errorMessage);
        }

        return widget.builder(context, contest);
      },
    );
  }
}
