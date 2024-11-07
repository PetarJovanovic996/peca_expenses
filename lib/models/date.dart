import 'package:intl/intl.dart';

class MyDateFormat {
  // done: This is a good example for a [static] method, refactor
  static formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
