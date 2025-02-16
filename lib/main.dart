import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/pages/detail/detail_page.dart';
import 'package:resto_spot/pages/main/main_page.dart';
import 'package:resto_spot/provider/bottom_navigation/bottom_navigation_provider.dart';
import 'package:resto_spot/provider/detail/restaurant_detail_provider.dart';
import 'package:resto_spot/provider/favourite/favourite_restaurant_provider.dart';
import 'package:resto_spot/provider/home/restaurant_list_provider.dart';
import 'package:resto_spot/provider/notification/notification_provider.dart';
import 'package:resto_spot/provider/reviews/review_restaurant_provider.dart';
import 'package:resto_spot/provider/search/search_restaurant_provider.dart';
import 'package:resto_spot/provider/setting/theme_provider.dart';
import 'package:resto_spot/routes/navigation.dart';
import 'package:resto_spot/services/notification_service.dart';
import 'package:resto_spot/services/setting_service.dart';
import 'package:resto_spot/services/sqlite_service.dart';
import 'package:resto_spot/style/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => ApiServices()),
      Provider(create: (_) => SqliteService()),
      Provider(create: (_) => SettingService(prefs)),
      Provider(
        create: (context) => NotificationService()
          ..init()
          ..configureLocalTimeZone(),
      ),
      ChangeNotifierProvider(
        create: (_) => BottomNavigationProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            RestaurantListProvider(context.read<ApiServices>()),
      ),
      ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiServices>())),
      ChangeNotifierProvider(
        create: (context) =>
            SearchRestaurantProvider(context.read<ApiServices>()),
      ),
      ChangeNotifierProvider(
          create: (context) =>
              ReviewRestaurantProvider(context.read<ApiServices>())),
      ChangeNotifierProvider(
          create: (context) =>
              FavouriteRestaurantProvider(context.read<SqliteService>())),
      ChangeNotifierProvider(
          create: (context) => ThemeProvider(context.read<SettingService>())),
      ChangeNotifierProvider(
          create: (context) => NotificationProvider(
              context.read<NotificationService>(),
              context.read<SettingService>()))
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ThemeProvider>().getSettingTheme();
      context.read<NotificationProvider>().getSettingNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, provider, child) {
        bool isDarkTheme = provider.setting?.isDarkTheme ?? false;

        return MaterialApp(
          title: "Resto Spot",
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          initialRoute: Navigation.homepage.name,
          routes: {
            Navigation.homepage.name: (context) => const MainPage(),
            Navigation.detailpage.name: (context) => DetailPage(
                  idRestaurant:
                      ModalRoute.of(context)?.settings.arguments as String,
                )
          },
        );
      },
    );
  }
}
