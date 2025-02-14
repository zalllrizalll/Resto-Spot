import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/pages/favourite/favourite_page.dart';
import 'package:resto_spot/pages/home/home_page.dart';
import 'package:resto_spot/pages/search/search_page.dart';
import 'package:resto_spot/pages/setting/setting_page.dart';
import 'package:resto_spot/provider/bottom_navigation/bottom_navigation_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex:
              context.watch<BottomNavigationProvider>().indexNavigation,
          onTap: (value) {
            context.read<BottomNavigationProvider>().setIndexNavigation = value;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              tooltip: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              tooltip: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: 'Favourite',
              tooltip: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
              tooltip: 'Setting',
            ),
          ]),
      body:
          Consumer<BottomNavigationProvider>(builder: (context, value, child) {
        return switch (value.indexNavigation) {
          3 => const SettingPage(),
          2 => const FavouritePage(),
          1 => const SearchPage(),
          _ => const HomePage(),
        };
      }),
    );
  }
}
