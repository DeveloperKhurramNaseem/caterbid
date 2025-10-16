import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats a DateTime into something like: "Oct 15, 2025, 4:30 PM"
  static String format(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy, h:mm a').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// shorter version for list items, e.g. "Oct 15, 4:30 PM"
  static String short(DateTime date) {
    try {
      return DateFormat('MMM d, h:mm a').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// For debug logs
  static String iso(DateTime date) {
    return date.toIso8601String();
  }
}
