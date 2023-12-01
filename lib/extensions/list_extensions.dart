extension ListTransformation on List<Object> {
  List<Map<String, dynamic>> castIdbResultList() {
    final List<Map<String, dynamic>> casted = <Map<String, dynamic>>[];

    for (final Object obj in this) {
      final Map<String, dynamic>? map = _castIdbResult(obj);

      if (map != null) {
        casted.add(map);
      }
    }
    return casted;
  }

  Map<String, dynamic>? _castIdbResult(Object? res) {
    if (res == null) {
      return null;
    }

    final Map<dynamic, dynamic> map = res as Map<dynamic, dynamic>;

    return Map<String, dynamic>.from(
      map.map(
            (Object? key, Object? value) {
          return MapEntry<String, dynamic>(key.toString(), value);
        },
      ),
    );
  }
}
