import 'package:beat_for_beat/extensions/extensions.dart';
import 'package:beat_for_beat/main.dart';
import 'package:beat_for_beat/pages/start_new_program_page.dart';
import 'package:flutter/material.dart';

class StartMenuPage extends StatelessWidget {
  const StartMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    Colors.black.brightness;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          const _Logo(),
          _StartMenuListItem(
            icon: Icons.play_arrow,
            text: 'Start ny konkurranse',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const StartNewProgramPage(),
                ),
              );
            },
          ),
          _StartMenuListItem(
            icon: Icons.double_arrow,
            text: 'Fortsett konkurranse',
            onPressed: () {},
          ),
          _StartMenuListItem(
            icon: Icons.add,
            text: 'Lag nytt program',
            onPressed: () {},
          ),
          _StartMenuListItem(
            icon: Icons.edit,
            text: 'Endre program',
            onPressed: () {},
          ),
          _StartMenuListItem(
            icon: Icons.settings,
            text: 'Innstillinger',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: BeatForBeatApp.themeColor,
      child: Text(
        'BfB',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 100.0,
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          letterSpacing: 5.0,
        ),
      ),
    );
  }
}

class _StartMenuListItem extends StatelessWidget {
  const _StartMenuListItem({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 1.0),
          Row(
            children: <Widget>[
              SizedBox(
                height: 60.0,
                width: 60.0,
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30.0,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          const Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
