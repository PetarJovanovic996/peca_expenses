import 'package:intl/intl.dart';

class MyDateFormat {
  // TODO: This is a good example for a [static] method, refactor
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
