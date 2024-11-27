import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  /// 1-create an instance of shared preferences
  static late SharedPreferences _preference;

  /// 2-create an init function to initialize shared preferences
  static Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }

  /// 3-Create a function to save bool data to shared preferences
  static saveBoolData(String key, bool value) {
    return _preference.setBool(key, value);
  }

  /// 4-Create a function to get bool data from shared preferences
  static getBoolData(String key) {
    return _preference.getBool(key) ?? false;
  }

  /// 5- Create a generic function to save data to shared preferences
  static saveData({required String key, required dynamic value}) {
    switch (value) {
      case bool value:
        return _preference.setBool(key, value);
      case int value:
        return _preference.setInt(key, value);
      case double value:
        return _preference.setDouble(key, value);
      case String value:
        return _preference.setString(key, value);
      default:
        throw Exception('Unsupported data type');
    }
  }

  /// 6- Create a generic function to get data from shared preferences
  static getData(String key) {
    return _preference.get(key);
  }
}
