import 'dart:convert';

int parseInt(Object? value) {
  if (value == null) {
    throw TypeError();
  }

  return int.parse(value.toString());
}

int? tryParseInt(Object? value) {
  if (value == null) {
    return null;
  }

  return int.tryParse(value.toString());
}

String parseString(Object? value) {
  if (value == null) {
    throw TypeError();
  }

  return value as String;
}

String? tryParseString(Object? value) {
  return value as String?;
}

bool parseBool(Object? value) {
  if (value == null) {
    throw TypeError();
  }

  return value == 1 || value == '1' || value == true || value == 'true';
}

bool? tryParseBool(Object? value) {
  if (value == null) {
    return null;
  }

  return parseBool(value);
}

double parseDouble(Object? value) {
  if (value == null) {
    throw TypeError();
  }

  return double.parse(value.toString());
}

double? tryParseDouble(Object? value) {
  if (value == null) {
    return null;
  }

  return double.tryParse(value.toString());
}

DateTime parseDateTime(Object? value) {
  if (value == null) {
    throw TypeError();
  }

  final int? parsedInt = tryParseInt(value);

  return parsedInt != null
      ? DateTime.fromMillisecondsSinceEpoch(
          parsedInt,
          isUtc: true,
        ).toLocal()
      : DateTime.parse(value.toString()).toLocal();
}

DateTime? tryParseDateTime(Object? value) {
  if (value == null) {
    return null;
  }

  final int? parsedInt = tryParseInt(value);

  return parsedInt != null
      ? DateTime.fromMillisecondsSinceEpoch(
          parsedInt,
          isUtc: true,
        ).toLocal()
      : DateTime.tryParse(value.toString())?.toLocal();
}

Map<String, dynamic> parseMap(Object? value) {
  if (value == null) {
    throw TypeError();
  }

  if (value is String) {
    return jsonDecode(value) as Map<String, dynamic>;
  } else {
    return value as Map<String, dynamic>;
  }
}

Map<String, dynamic>? tryParseMap(Object? value) {
  if (value == null) {
    return null;
  }

  return parseMap(value);
}

dynamic parseDynamic(Object? value) {
  return value;
}

dynamic tryParseDynamic(Object? value) {
  return parseDynamic(value);
}

dynamic serializeInt(int? value) {
  return value;
}

dynamic serializeString(String? value) {
  return value;
}

// ignore: avoid_positional_boolean_parameters
dynamic serializeBool(bool? value) {
  if (value == null) {
    return null;
  }

  return value;
}

dynamic serializeDouble(double? value) {
  if (value == null) {
    return null;
  }

  return value;
}

dynamic serializeDateTime(DateTime? value) {
  if (value == null) {
    return null;
  }

  return value.toIso8601String();
}

dynamic serializeMap(Map<String, dynamic>? value) {
  if (value == null) {
    return null;
  }

  return jsonEncode(value);
}

dynamic serializeDynamic(Object? value) {
  return value;
}
