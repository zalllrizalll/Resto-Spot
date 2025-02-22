import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/pages/detail/detail_page.dart';
import 'package:resto_spot/provider/bottom_navigation/bottom_navigation_provider.dart';
import 'package:resto_spot/provider/detail/restaurant_detail_provider.dart';
import 'package:resto_spot/provider/favourite/favourite_icon_provider.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class HomePageRobot {
  final WidgetTester tester;

  HomePageRobot(this.tester);

  final listCardHome = const ValueKey('listCardHome');
  final restaurantCardKey = const ValueKey('restaurantCardHome');

  final homePage = const ValueKey('homePage');
  final searchPage = const ValueKey('searchPage');
  final favouritePage = const ValueKey('favouritePage');
  final settingPage = const ValueKey('settingPage');

  Future<void> loadUI(Widget widget) async {
    Future.delayed(Duration.zero);
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(MultiProvider(
      providers: [
        Provider(create: (_) => ApiServices()),
        Provider(create: (_) => SqliteService()),
        Provider(create: (_) => SettingService(prefs)),
        Provider(
          create: (context) => NotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider<RestaurantListProvider>(
            create: (context) =>
                RestaurantListProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(
            create: (context) =>
                RestaurantDetailProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(
            create: (context) =>
                FavouriteRestaurantProvider(context.read<SqliteService>())),
        ChangeNotifierProvider(create: (_) => FavouriteIconProvider()),
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(context.read<SettingService>())),
        ChangeNotifierProvider(
            create: (context) => NotificationProvider(
                context.read<NotificationService>(),
                context.read<SettingService>())),
        ChangeNotifierProvider(
            create: (context) =>
                ReviewRestaurantProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(
            create: (context) =>
                SearchRestaurantProvider(context.read<ApiServices>()))
      ],
      child: MaterialApp(
        home: widget,
        debugShowCheckedModeBanner: false,
        initialRoute: Navigation.homepage.name,
        routes: {
          Navigation.detailpage.name: (context) => DetailPage(
              idRestaurant:
                  ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    ));
    await tester.pumpAndSettle();
  }

  Future<void> scrollUpListView() async {
    final listViewFinder = find.byKey(listCardHome);

    await tester.fling(listViewFinder, const Offset(0, 300), 1000);

    await tester.pumpAndSettle();
  }

  Future<void> scrollDownListView() async {
    final listViewFinder = find.byKey(listCardHome);

    await tester.fling(listViewFinder, const Offset(0, -300), 1000);

    await tester.pumpAndSettle();
  }

  Future<void> tapRestaurantCard() async {
    final restaurantFinder = find.byKey(restaurantCardKey);

    await tester.tap(restaurantFinder.first);
    await tester.pumpAndSettle();
  }

  Future<void> moveToHomePage() async {
    await tester.tap(find.byKey(homePage));
    await tester.pumpAndSettle();
  }

  Future<void> moveToSearchPage() async {
    await tester.tap(find.byKey(searchPage));
    await tester.pumpAndSettle();
  }

  Future<void> moveToFavouritePage() async {
    await tester.tap(find.byKey(favouritePage));
    await tester.pumpAndSettle();
  }

  Future<void> moveToSettingPage() async {
    await tester.tap(find.byKey(settingPage));
    await tester.pumpAndSettle();
  }
}
