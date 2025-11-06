// user_session.dart
class UserSession {
  static String? _role;

  static void setRole(String role) => _role = role;
  static void clearSession() => _role = null;


  static bool get isRequestee => _role == 'requestee';
  static bool get isProvider => _role == 'provider';
  static String? get role => _role;
}

