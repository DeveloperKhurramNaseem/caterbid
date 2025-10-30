import 'package:intl/intl.dart';

class DateFormatter {
  /// Treats the stored date as-is (UTC) and formats it directly
  static String formatExact(DateTime utcDate) {
    try {
      // Ensure we're formatting the UTC time, not local
      final utcFormatter = DateFormat('MMM d, yyyy, h:mm a');
      return utcFormatter.format(utcDate.toUtc()); // Force UTC
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Full format in LOCAL time: "Oct 15, 2025, 4:30 PM"
  static String format(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy, h:mm a').format(date.toLocal());
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Short format for lists: "Oct 15, 4:30 PM" (LOCAL)
  static String short(DateTime date) {
    try {
      return DateFormat('MMM d, h:mm a').format(date.toLocal());
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Just the date: "Oct 15, 2025" (LOCAL)
  static String onlyDate(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy').format(date.toLocal());
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Just the time: "4:30 PM" (LOCAL)
  static String onlyTime(DateTime date) {
    try {
      return DateFormat('h:mm a').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// Full date and time: "Sept 6, 2024 at 1:30 pm" (LOCAL)
  static String fullDateTime(DateTime date) {
    try {
      return DateFormat('MMM d, yyyy \'at\' h:mm a').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }

  /// ISO string for debug/logging (UTC)
  static String iso(DateTime date) {
    return date.toUtc().toIso8601String();
  }

  /// NEW: Format UTC time with "UTC" label
  static String formatExactWithLabel(DateTime utcDate) {
    try {
      final formatted = DateFormat('MMM d, yyyy, h:mm a').format(utcDate.toUtc());
      return '$formatted UTC';
    } catch (_) {
      return 'Invalid date';
    }
  }
}