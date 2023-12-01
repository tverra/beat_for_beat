import 'package:beat_for_beat/database/db_repo.dart' as db_repo;
import 'package:beat_for_beat/extensions/extensions.dart';
import 'package:beat_for_beat/models/contest.dart';
import 'package:flutter/material.dart';

class ContestsBuilder extends StatefulWidget {
  const ContestsBuilder({
    super.key,
    required this.builder,
    required this.onError,
    this.finished,
  });
  
  final Widget Function(BuildContext context, List<Contest>? contests) builder;
  final void Function(BuildContext context, String errorMessage) onError;
  final bool? finished;

  @override
  State<ContestsBuilder> createState() => _ContestsBuilderState();
}

class _ContestsBuilderState extends State<ContestsBuilder> {
  late final Future<List<Contest>> _contestsFuture;

  @override
  void initState() {
    super.initState();
     
    _contestsFuture = db_repo.getContests(finished: widget.finished);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contest>>(
      future: _contestsFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Contest>> snapshot) {
        final List<Contest>? contests = snapshot.data;

        if (snapshot.hasError || (snapshot.isDone && !snapshot.hasData)) {
          late final String errorMessage;

          if (snapshot.hasError) {
            errorMessage = snapshot.error.toString();
          } else {
            errorMessage = 'Error: could not load contests';
          }

          widget.onError(context, errorMessage);
        }

        return widget.builder(context, contests);
      },
    );
  }
}
