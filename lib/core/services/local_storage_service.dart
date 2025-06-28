// // import 'package:shared_preferences/shared_preferences.dart';

// /// A service for storing and retrieving local key-value data
// class LocalStorageService {
//   // static SharedPreferences? _prefs;

//   /// Initializes the storage instance
//   static Future<void> init() async {
//     // _prefs = await SharedPreferences.getInstance();
//   }

//   /// Saves a string value by key
//   static Future<void> setString(String key, String value) async {
//     await _prefs?.setString(key, value);
//   }

//   /// Retrieves a string value by key
//   static String? getString(String key) {
//     return _prefs?.getString(key);
//   }

//   /// Saves a boolean value by key
//   static Future<void> setBool(String key, bool value) async {
//     await _prefs?.setBool(key, value);
//   }

//   /// Retrieves a boolean value by key
//   static bool getBool(String key, {bool defaultValue = false}) {
//     return _prefs?.getBool(key) ?? defaultValue;
//   }

//   /// Clears all stored data
//   static Future<void> clear() async {
//     await _prefs?.clear();
//   }

//   /// Removes a specific key
//   static Future<void> remove(String key) async {
//     await _prefs?.remove(key);
//   }
// }
