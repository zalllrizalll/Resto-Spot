import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/pages/detail/detail_page.dart';
import 'package:resto_spot/pages/main/main_page.dart';
import 'package:resto_spot/provider/bottom_navigation/bottom_navigation_provider.dart';
import 'package:resto_spot/provider/detail/restaurant_detail_provider.dart';
import 'package:resto_spot/provider/favourite/favourite_restaurant_provider.dart';
import 'package:resto_spot/provider/home/restaurant_list_provider.dart';
import 'package:resto_spot/provider/reviews/review_restaurant_provider.dart';
import 'package:resto_spot/provider/search/search_restaurant_provider.dart';
import 'package:resto_spot/routes/navigation.dart';
import 'package:resto_spot/services/sqlite_service.dart';
import 'package:resto_spot/style/theme/custom_theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => ApiServices()),
      Provider(create: (_) => SqliteService()),
      ChangeNotifierProvider(
        create: (context) =>
            RestaurantListProvider(context.read<ApiServices>()),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantDetailProvider(
          context.read<ApiServices>()
        )
      ),
      ChangeNotifierProvider(
        create: (context) => BottomNavigationProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SearchRestaurantProvider(
          context.read<ApiServices>()
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => ReviewRestaurantProvider(
          context.read<ApiServices>()
        )
      ),
      ChangeNotifierProvider(
        create: (context) => FavouriteRestaurantProvider(
          context.read<SqliteService>()
        )
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Resto Spot",
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Navigation.homepage.name,
      routes: {
        Navigation.homepage.name: (context) => const MainPage(),
        Navigation.detailpage.name: (context) => DetailPage(
          idRestaurant: ModalRoute.of(context)?.settings.arguments as String,
        )
      },
    );
  }
}
