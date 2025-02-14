import 'package:flutter/material.dart';
import 'package:resto_spot/data/model/setting.dart';
import 'package:resto_spot/services/setting_service.dart';

class SettingProvider extends ChangeNotifier {
  final SettingService _service;

  SettingProvider(this._service);

  String _message = '';
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  Future<void> saveSettingTheme(Setting setting) async {
    try {
      await _service.saveSettingTheme(setting);
      _message = 'Success to save setting theme';
    } catch (e) {
      _message = 'Failed to save setting theme';
    }
    notifyListeners();
  }

  void getSettingTheme() {
    try {
      _setting = _service.getSettingTheme();
      _message = 'Success to get setting theme';
    } catch (e) {
      _message = 'Failed to get setting theme';
    }
    notifyListeners();
  }
}
