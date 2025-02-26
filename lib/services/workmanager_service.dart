import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/services/notification_service.dart';
import 'package:resto_spot/static/my_workmanager.dart';
import 'package:resto_spot/utils/helper/datetime_helper.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  try {
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  } catch (e) {
    tz.setLocalLocation(tz.getLocation('UTC'));
  }

  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettingsIOS = DarwinInitializationSettings();
  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  Workmanager().executeTask((task, inputData) async {
    if (task == MyWorkmanager.periodic.taskName) {
      final apiServices = ApiServices();
      try {
        final result = await apiServices.getListRestaurants();
        if (result.restaurants.isNotEmpty) {
          final randomRestaurant = (result.restaurants..shuffle()).first;
          await NotificationService().scheduleDailyElevenAMNotification(
              id: 1,
              channelId: '1',
              channelName: 'Daily Restaurant Reminder',
              title: '🍽️ Let’s grab lunch at ${randomRestaurant.name}!',
              body:
                  'Explore the flavors of ${randomRestaurant.city} — you won’t regret it! 🌟',
              payload: randomRestaurant.id);
        }
      } catch (e) {
        throw Exception(e);
      }
    }
    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<bool?> requestPermissions() async {
    return await NotificationService().requestPermissions();
  }

  Future<void> runDailyReminderTask() async {
    final now = tz.TZDateTime.now(tz.local);
    final nextElevenAM = DatetimeHelper().nextInstanceOfElevenAM();
    final initialDelay = nextElevenAM.difference(now);

    await _workmanager.registerPeriodicTask(
        MyWorkmanager.periodic.uniqueName, MyWorkmanager.periodic.taskName,
        frequency: const Duration(hours: 24),
        initialDelay: initialDelay,
        inputData: {'message': 'Daily reminder task is running'});
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
