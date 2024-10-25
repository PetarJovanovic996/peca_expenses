import 'package:intl/intl.dart';

class MyDateFormat {
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }
}
