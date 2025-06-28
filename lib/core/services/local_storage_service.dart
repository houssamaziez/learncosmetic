import 'package:get_storage/get_storage.dart';

/// A service for storing and retrieving local key-value data using GetStorage
class LocalStorageService {
  static final GetStorage _box = GetStorage();

  /// Initializes the storage (must be called before any access)
  static Future<void> init() async {
    await GetStorage.init();
  }

  /// Saves a string value by key
  static void setString(String key, String value) {
    _box.write(key, value);
  }

  /// Retrieves a string value by key
  static String? getString(String key) {
    return _box.read<String>(key);
  }

  /// Saves a boolean value by key
  static void setBool(String key, bool value) {
    _box.write(key, value);
  }

  /// Retrieves a boolean value by key
  static bool getBool(String key, {bool defaultValue = false}) {
    return _box.read<bool>(key) ?? defaultValue;
  }

  /// Clears all stored data
  static Future<void> clear() async {
    await _box.erase();
  }

  /// Removes a specific key
  static Future<void> remove(String key) async {
    await _box.remove(key);
  }
}
