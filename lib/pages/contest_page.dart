import 'package:beat_for_beat/models/contest.dart';
import 'package:beat_for_beat/models/team.dart';
import 'package:beat_for_beat/widgets/contest_builder.dart';
import 'package:beat_for_beat/widgets/dual_box_layout.dart';
import 'package:beat_for_beat/widgets/error_dialog.dart';
import 'package:beat_for_beat/widgets/teams_builder.dart';
import 'package:flutter/material.dart';

class ContestPage extends StatelessWidget {
  const ContestPage({super.key, required this.contest});

  final Contest contest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContestBuilder(
        contest: contest,
        onError: (BuildContext context, String errorMessage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showErrorDialog<void>(context, errorMessage);
          });
        },
        builder: (BuildContext context, Contest? contest) {
          return TeamsBuilder(
            contest: this.contest,
            onError: (BuildContext context, String errorMessage) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showErrorDialog<void>(context, errorMessage);
              });
            },
            builder: (BuildContext context, List<Team>? teams) {
              Team? team1;
              Team? team2;

              if (teams != null && teams.length == 2) {
                team1 = teams[0];
                team2 = teams[1];
              }

              return DualBoxLayout(
                startBox: Text(team1?.name ?? 'null'),
                endBox: Text(team2?.name ?? 'null'),
              );
            },
          );
        },
      ),
    );
  }
}
