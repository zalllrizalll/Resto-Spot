import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/data/model/setting.dart';
import 'package:resto_spot/provider/setting/setting_provider.dart';
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
            child: Consumer<SettingProvider>(builder: (_, provider, child) {
              bool isDarkTheme = provider.setting?.isDarkTheme ?? false;

              return Row(
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
                      value: isDarkTheme,
                      onChanged: (value) async {
                        await provider
                            .saveSettingTheme(Setting(isDarkTheme: value));
                        provider.getSettingTheme();
                      })
                ],
              );
            })));
  }
}
