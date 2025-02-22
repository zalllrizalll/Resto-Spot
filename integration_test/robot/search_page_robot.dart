import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SearchPageRobot {
  final WidgetTester tester;

  SearchPageRobot(this.tester);

  final searchRestaurant = const ValueKey('searchRestaurant');
  final restaurantCardSearch = const ValueKey('restaurantCardSearch');

  Future<void> searchResto() async {
    await tester.tap(find.byKey(searchRestaurant));
    await tester.pumpAndSettle();

    const searchText = 'Kafe';

    for (int i = 0; i < searchText.length; i++) {
      await tester.enterText(
          find.byKey(searchRestaurant), searchText.substring(0, i + 1));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
  }

  Future<void> tapRestaurantCardSearch() async {
    await tester.tap(find.byKey(restaurantCardSearch).first);
    await tester.pumpAndSettle();
  }
}
