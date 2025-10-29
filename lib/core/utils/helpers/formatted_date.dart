import 'package:intl/intl.dart';

class DateFormatter {

    /// Treats the stored date as-is without converting to local timezone
  static String formatExact(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy, h:mm a').format(date); // no .toLocal()
    } catch (_) {
      return 'Invalid date';
    }
  }
  /// Full format: "Oct 15, 2025, 4:30 PM"
  static String format(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy, h:mm a').format(date.toLocal());
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Short format for lists: "Oct 15, 4:30 PM"
  static String short(DateTime date) {
    try {
      return DateFormat('MMM d, h:mm a').format(date.toLocal());
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Just the date: "Oct 15, 2025"
  static String onlyDate(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy').format(date.toLocal());
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Just the time: "4:30 PM"
  static String onlyTime(DateTime date) {
    try {
      return DateFormat('h:mm a').format(date.toLocal());
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Full date and time: "Sept 6, 2024 at 1:30 pm"
  static String fullDateTime(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy \'at\' h:mm a').format(date.toLocal());
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// ISO string for debug/logging
  static String iso(DateTime date) {
    return date.toIso8601String();
  }
}