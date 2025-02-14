import 'package:resto_spot/data/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  final SharedPreferences _preferences;

  SettingService(this._preferences);

  static const String keyTheme = 'MY_THEME';

  Future<void> saveSettingTheme(Setting setting) async {
    try {
      await _preferences.setBool(keyTheme, setting.isDarkTheme);
    } catch (e) {
      throw Exception('Failed to save setting theme');
    }
  }

  Setting getSettingTheme() {
    return Setting(isDarkTheme: _preferences.getBool(keyTheme) ?? false);
  }
}
