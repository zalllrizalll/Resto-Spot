import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SettingPageRobot {
  final WidgetTester tester;

  SettingPageRobot(this.tester);

  final switchTheme = const ValueKey('switchTheme');

  Future<void> tapSwitchTheme() async {
    await tester.tap(find.byKey(switchTheme));
    await tester.pumpAndSettle();
  }
}
