extension ObjectTransformation on Object {
  Map<String, dynamic> castIdbResult() {
    final Map<dynamic, dynamic> map = this as Map<dynamic, dynamic>;

    return Map<String, dynamic>.from(
      map.map(
        (Object? key, Object? value) {
          return MapEntry<String, dynamic>(key.toString(), value);
        },
      ),
    );
  }

  List<Map<String, dynamic>> castIdbResultList() {
    final List<Map<String, dynamic>> casted = <Map<String, dynamic>>[];

    for (final Object obj in this as List<Object>) {
      casted.add(obj.castIdbResult());
    }
    return casted;
  }
}
