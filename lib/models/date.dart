import 'package:intl/intl.dart';

class MyDateFormat {
  static formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
