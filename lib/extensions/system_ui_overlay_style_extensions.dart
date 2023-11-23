import 'package:flutter/services.dart';

extension SystemUiOverlayStylesUtilities on SystemUiOverlayStyle {
  SystemUiOverlayStyle matchBrightness(Brightness brightness) {
    return brightness == Brightness.light
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
  }
}
