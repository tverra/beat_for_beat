import 'dart:ui';

extension BrightnessTransformations on Brightness {
  Brightness get inverted {
    return this == Brightness.light ? Brightness.dark : Brightness.light;
  }
}

extension BrightnessUtilities on Brightness {
  bool get isLight => this == Brightness.light;

  bool get isDark => this == Brightness.dark;
}
