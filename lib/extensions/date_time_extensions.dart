import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String format({
    String pattern = 'dd.MM.yyyy HH:mm:ss',
    String locale = 'no',
  }) {
    final DateFormat formatter = DateFormat(pattern, locale);
    return formatter.format(this);
  }
}
