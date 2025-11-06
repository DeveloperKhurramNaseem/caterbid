import 'package:caterbid/core/utils/helpers/storage/prefs/shared_preferences.dart';
import 'package:caterbid/core/utils/helpers/storage/prefs/secure_storage.dart';
import 'package:caterbid/core/utils/helpers/storage/prefs/user_session.dart';

class AuthUtils {
  /// Clears all locally stored authentication data.
  static Future<void> cleanUpTokenData() async {
    await SecureStorage.clearToken();
    await SharedPrefs.deleteTokenIssueDate();
    await SharedPrefs.clearUserRole();
    await SharedPrefs.clearLocationRequired();
    UserSession.clearSession();
  }
}
