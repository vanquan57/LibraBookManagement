// lib/core/storage/local_storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalStorageService {
  final SharedPreferences _preferences;
  
  // SYNC constructor injection
  LocalStorageService(this._preferences);

  // Save access token
  Future<void> saveAccessToken(String token) async {
    await _preferences.setString('access_token', token);
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return _preferences.getString('access_token');
  }

  // Clear all data
  Future<void> clear() async {
    await _preferences.clear();
  }
}

@module
abstract class LocalStorageModule {
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
