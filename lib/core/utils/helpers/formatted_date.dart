import 'package:intl/intl.dart';

class DateFormatter {
  /// Full format: "Oct 15, 2025, 4:30 PM"
  static String format(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy, h:mm a').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Short format for lists: "Oct 15, 4:30 PM"
  static String short(DateTime date) {
    try {
      return DateFormat('MMM d, h:mm a').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Just the date: "Oct 15, 2025"
  static String onlyDate(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Just the time: "4:30 PM"
  static String onlyTime(DateTime date) {
    try {
      return DateFormat('h:mm a').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// ISO string for debug/logging
  static String iso(DateTime date) {
    return date.toIso8601String();
  }
}
