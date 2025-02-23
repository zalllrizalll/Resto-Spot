import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FavouritePageRobot {
  final WidgetTester tester;

  FavouritePageRobot(this.tester);

  final restaurantCardFavourite = const ValueKey('restaurantCardFavourite');

  Future<void> tapRestaurantCardFavourite() async {
    await tester.tap(find.byKey(restaurantCardFavourite).first);
    await tester.pumpAndSettle();
  }
}
