import 'package:shared_preferences/shared_preferences.dart';

class AppLocal {
  static String focusTimer = 'FOCUS';
  static String shortTimer = 'SHORT';
  static String longTimer = 'LONG';
  // set
  static cacheData(String key, value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  //get
  static Future<int?> getCachedData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }
}
