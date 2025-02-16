import 'package:flutter/material.dart';
import 'package:resto_spot/data/model/notification_setting.dart';
import 'package:resto_spot/services/notification_service.dart';
import 'package:resto_spot/services/setting_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _service;
  final SettingService _settingService;

  NotificationProvider(this._service, this._settingService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  String _message = '';
  String get message => _message;

  NotificationSetting? _settingNotification;
  NotificationSetting? get settingNotification => _settingNotification;

  Future<void> requestPermissions() async {
    _permission = await _service.requestPermissions();
    notifyListeners();
  }

  void scheduleDailyElevenAMNotification() {
    _notificationId += 1;
    _service.scheduleDailyElevenAMNotification(id: _notificationId);
  }

  Future<void> cancelNotification(int id) async {
    await _service.cancelNotification(id);
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
