import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const _accessTokenKey = 'accessToken';

  // The function to save access token
  Future<void> saveAccessToken(String token) async {
    await _preferences?.setString(_accessTokenKey, token);
  }

  // The function to retrieve access token
  Future<String?> getAccessToken() async {
    return _preferences?.getString(_accessTokenKey);
  }

  // The function to delete all tokens (when the user logs out)
  Future<void> deleteAllTokens() async {
    await _preferences?.remove(_accessTokenKey);
  }
}
