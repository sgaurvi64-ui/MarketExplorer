import 'package:intl/intl.dart';

class DateTimeUtils {
  static final DateFormat _shortDate = DateFormat('dd MMM yyyy');
  static final DateFormat _dateTime = DateFormat('dd MMM yyyy, hh:mm a');

  static String formatDate(DateTime value) => _shortDate.format(value);

  static String formatDateTime(DateTime value) => _dateTime.format(value);
}
