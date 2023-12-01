import 'package:beat_for_beat/models/contest.dart';
import 'package:beat_for_beat/models/team.dart';
import 'package:beat_for_beat/pages/program_page.dart';
import 'package:beat_for_beat/widgets/async_elevated_button.dart';
import 'package:beat_for_beat/widgets/dual_box_layout.dart';
import 'package:beat_for_beat/widgets/error_dialog.dart';
import 'package:flutter/material.dart';

class StartNewProgramPage extends StatefulWidget {
  const StartNewProgramPage({super.key});

  @override
  State<StartNewProgramPage> createState() => _StartNewProgramPageState();
}

class _StartNewProgramPageState extends State<StartNewProgramPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start nytt program'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            DualBoxLayout(
              startBox: _NewTeamBox(
                controller: _textFieldController1,
                title: 'Lag 1',
                textInputAction: TextInputAction.next,
                autofocus: true,
              ),
              endBox: _NewTeamBox(
                controller: _textFieldController2,
                title: 'Lag 2',
                textInputAction: TextInputAction.done,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AsyncElevatedButton(
                onPressed: () async {
                  final Contest? contest = await _saveData()
                      .onError((Object? error, StackTrace stacktrace) async {
                    return showErrorDialog(context, error.toString());
                  });

                  if (context.mounted && contest != null) {
                    await Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => ProgramPage(
                          contest: contest,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('START'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Contest?> _saveData() async {
    final FormState? formState = _formKey.currentState;

    if (formState == null || !formState.validate()) {
      return null;
    }

    final Contest contest = Contest();

    if (!await contest.save()) {
      return Future<Contest?>.error('Failed to save contest: $contest');
    }

    final Team team1 = Team(
      name: _textFieldController1.text,
      contestKey: contest.key,
    );

    final Team team2 = Team(
      name: _textFieldController2.text,
      contestKey: contest.key,
    );

    if (!await team1.save()) {
      return Future<Contest?>.error('Failed to save team: $team1');
    }

    if (!await team2.save()) {
      return Future<Contest?>.error('Failed to save team: $team2');
    }

    return contest;
  }
}

class _NewTeamBox extends StatelessWidget {
  const _NewTeamBox({
    required this.controller,
    required this.title,
    this.textInputAction,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final String title;
  final TextInputAction? textInputAction;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 80.0,
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Lagnavn',
            ),
            textCapitalization: TextCapitalization.sentences,
            textInputAction: textInputAction,
            autofocus: autofocus,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Lagnavn er påkrevd';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
