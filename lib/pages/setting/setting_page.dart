import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/data/model/notification_setting.dart';
import 'package:resto_spot/data/model/theme_mode_setting.dart';
import 'package:resto_spot/provider/notification/notification_provider.dart';
import 'package:resto_spot/provider/setting/theme_provider.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.blue.color,
          title: Text(
            'Setting',
            style: TextStyle(
              color: CustomColors.white.color,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer2<ThemeProvider, NotificationProvider>(
                builder: (context, themeProvider, notificationProvider, child) {
              bool isDarkTheme = themeProvider.setting?.isDarkTheme ?? false;
              bool isNotificationEnabled = notificationProvider
                      .settingNotification?.isEnabledNotification ??
                  false;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dark Mode',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox.square(dimension: 4),
                            Text(
                              isDarkTheme ? 'Enabled' : 'Disabled',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Switch(
                          key: const ValueKey('switchTheme'),
                          value: isDarkTheme,
                          onChanged: (value) async {
                            await themeProvider.saveSettingTheme(
                                ThemeModeSetting(isDarkTheme: value));
                            themeProvider.getSettingTheme();
                          }),
                    ],
                  ),
                  const SizedBox.square(dimension: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Reminder',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox.square(dimension: 4),
                          Text(
                            isNotificationEnabled ? 'Enabled' : 'Disabled',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          )
                        ],
                      )),
                      Switch(
                          key: const ValueKey('switchNotification'),
                          value: isNotificationEnabled,
                          onChanged: (value) async {
                            if (value) {
                              await notificationProvider.requestPermissions();
                              notificationProvider.scheduleDailyReminder();
                            } else {
                              await notificationProvider.cancelDailyReminder();
                            }
                            await notificationProvider.saveSettingNotification(
                                NotificationSetting(
                                    isEnabledNotification: value));
                            notificationProvider.getSettingNotification();
                          })
                    ],
                  )
                ],
              );
            })));
  }
}
