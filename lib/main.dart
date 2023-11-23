import 'package:beat_for_beat/extensions/extensions.dart';
import 'package:beat_for_beat/pages/start_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const BeatForBeatApp());
}

class BeatForBeatApp extends StatelessWidget {
  const BeatForBeatApp({super.key});

  static const Color themeColor = Color(0xFF09118E);

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = themeColor.brightness.inverted;
    final SystemUiOverlayStyle systemOverlayStyle =
        const SystemUiOverlayStyle().matchBrightness(brightness);

    SystemChrome.setSystemUIOverlayStyle(systemOverlayStyle);

    return MaterialApp(
      title: 'Beat for Beat',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.notoSerifTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const ColoredBox(
        color: themeColor,
        child: SafeArea(
          child: StartMenuPage(),
        ),
      ),
    );
  }
}
