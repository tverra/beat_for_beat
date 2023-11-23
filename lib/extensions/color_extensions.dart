import 'dart:ui';

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
