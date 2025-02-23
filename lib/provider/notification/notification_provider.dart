import 'package:flutter/material.dart';
import 'package:resto_spot/data/model/notification_setting.dart';
import 'package:resto_spot/services/setting_service.dart';
import 'package:resto_spot/services/workmanager_service.dart';

class NotificationProvider extends ChangeNotifier {
  final WorkmanagerService _workmanagerService;
  final SettingService _settingService;

  NotificationProvider(this._workmanagerService, this._settingService);

  bool? _permission = false;
  bool? get permission => _permission;

  String _message = '';
  String get message => _message;

  NotificationSetting? _settingNotification;
  NotificationSetting? get settingNotification => _settingNotification;

  Future<void> requestPermissions() async {
    _permission = await _workmanagerService.requestPermissions();
    notifyListeners();
  }

  Future<void> scheduleDailyReminder() async {
    try {
      await _workmanagerService.runDailyReminderTask();
      _message = 'Daily reminder scheduled successfully';
    } catch (e) {
      _message = 'Failed to schedule daily reminder';
    }
    notifyListeners();
  }

  Future<void> cancelDailyReminder() async {
    try {
      await _workmanagerService.cancelAllTask();
      _message = 'Daily reminder canceled successfully';
    } catch (e) {
      _message = 'Failed to cancel daily reminder';
    }
    notifyListeners();
  }

  Future<void> saveSettingNotification(NotificationSetting setting) async {
    try {
      await _settingService.saveSettingNotification(setting);
      _message = 'Success to save setting notification';
    } catch (e) {
      _message = 'Failed to save setting notification';
    }
    notifyListeners();
  }

  void getSettingNotification() {
    try {
      _settingNotification = _settingService.getSettingNotification();
      _message = 'Success to get setting notification';
    } catch (e) {
      _message = 'Failed to get setting notification';
    }
    notifyListeners();
  }
}
