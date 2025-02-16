import 'package:resto_spot/data/model/notification_setting.dart';
import 'package:resto_spot/data/model/theme_mode_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingService {
  final SharedPreferences _preferences;

  SettingService(this._preferences);

  static const String keyTheme = 'MY_THEME';
  static const String keyNotification = 'MY_NOTIFICATION';

  Future<void> saveSettingTheme(ThemeModeSetting setting) async {
    try {
      await _preferences.setBool(keyTheme, setting.isDarkTheme);
    } catch (e) {
      throw Exception('Failed to save setting theme');
    }
  }

  ThemeModeSetting getSettingTheme() {
    return ThemeModeSetting(
        isDarkTheme: _preferences.getBool(keyTheme) ?? false);
  }

  Future<void> saveSettingNotification(NotificationSetting setting) async {
    try {
      await _preferences.setBool(
          keyNotification, setting.isEnabledNotification);
    } catch (e) {
      throw Exception('Failed to enable notification');
    }
  }

  NotificationSetting getSettingNotification() {
    return NotificationSetting(
        isEnabledNotification: _preferences.getBool(keyNotification) ?? false);
  }
}
