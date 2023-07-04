import 'package:intl/intl.dart';

class DateConverters {
  static String formatDate(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }
}
