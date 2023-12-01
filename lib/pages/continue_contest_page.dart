import 'package:beat_for_beat/extensions/extensions.dart';
import 'package:beat_for_beat/models/contest.dart';
import 'package:beat_for_beat/pages/contest_page.dart';
import 'package:beat_for_beat/widgets/contests_builder.dart';
import 'package:beat_for_beat/widgets/error_dialog.dart';
import 'package:flutter/material.dart';

class ContinueContestPage extends StatelessWidget {
  const ContinueContestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fortsett konkurranse'),
        centerTitle: true,
      ),
      body: ContestsBuilder(
        onError: (BuildContext context, String errorMessage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showErrorDialog<void>(context, errorMessage);
          });
        },
        builder: (BuildContext context, List<Contest>? contests) {
          if (contests != null && contests.isEmpty) {
            return const Center(
              child: Text('Fant ingen konkurranser'),
            );
          }

          return ListView.builder(
            itemCount: contests?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final Contest? contest = contests?[index];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    if (contest != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => ContestPage(
                            contest: contest,
                          ),
                        ),
                      );
                    }
                  },
                  child: Material(
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Opprettet: ${contest?.created?.format()}',
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
