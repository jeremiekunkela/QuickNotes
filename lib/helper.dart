import 'package:intl/intl.dart';

class AppHelper {
  static final DateFormat dateFormat = DateFormat('MMM dd, yyyy, hh:mm a');

  static String formatCurrentDate() {
    return dateFormat.format(DateTime.now());
  }
}
