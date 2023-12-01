import 'package:flutter/material.dart';

extension ColorTransformations on Color {
  Color get contrastTextColor {
    if (brightness == Brightness.light) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color getDarkerColor([double percent = 0.1]) {
    assert(
      0 <= percent && percent <= 1,
      'Invalid percent value: $percent. The value must be between 0 and 1.',
    );

    final double f = 1 - percent;

    return Color.fromARGB(
      alpha,
      (red * f).round(),
      (green * f).round(),
      (blue * f).round(),
    );
  }

  Color getLighterColor([double percent = 0.1]) {
    assert(
      0 <= percent && percent <= 1,
      'Invalid percent value: $percent. The value must be between 0 and 1.',
    );

    return Color.fromARGB(
      alpha,
      red + ((255 - red) * percent).round(),
      green + ((255 - green) * percent).round(),
      blue + ((255 - blue) * percent).round(),
    );
  }
}

extension ColorComputations on Color {
  Brightness get brightness {
    final double luminance = _cachedComputeLuminance(this);
    return luminance > 0.44 ? Brightness.light : Brightness.dark;
  }

  // Calls to Color.computeLuminance() should not be used more often than
  // necessary, since the value is computationally expensive to calculate
  static final Map<int, double> _luminanceCache = <int, double>{};

  double _cachedComputeLuminance(Color color) {
    final double? cacheValue = _luminanceCache[color.value];
    double luminance;

    if (cacheValue != null) {
      luminance = cacheValue;
    } else {
      luminance = color.computeLuminance();
      _luminanceCache.putIfAbsent(color.value, () => luminance);
    }
    return luminance;
  }
}
