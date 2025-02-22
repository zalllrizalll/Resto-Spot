import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DetailPageRobot {
  final WidgetTester tester;

  DetailPageRobot(this.tester);

  final bodyOfDetailPage = const ValueKey('bodyOfDetailPage');
  final menusFoodCard = const ValueKey('menusFoodCard');
  final menusDrinksCard = const ValueKey('menusDrinksCard');
  final favouriteIcon = const ValueKey('favouriteIcon');
  final tabOverview = const ValueKey('tabOverview');
  final tabReviews = const ValueKey('tabReviews');
  final reviewsPage = const ValueKey('reviewPage');

  Future<void> scrollUpDetailPage() async {
    await tester.fling(
        find.byKey(bodyOfDetailPage), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();
  }

  Future<void> scrollDownDetailPage() async {
    await tester.fling(
        find.byKey(bodyOfDetailPage), const Offset(0, -300), 1000);
    await tester.pumpAndSettle();
  }

  Future<void> scrollLeftMenusFoodCard() async {
    await tester.fling(find.byKey(menusFoodCard), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();
  }

  Future<void> scrollRightMenusFoodCard() async {
    await tester.fling(find.byKey(menusFoodCard), const Offset(300, 0), 1000);
    await tester.pumpAndSettle();
  }

  Future<void> scrollLeftMenusDrinksCard() async {
    await tester.fling(
        find.byKey(menusDrinksCard), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();
  }

  Future<void> scrollRightMenusDrinksCard() async {
    await tester.fling(find.byKey(menusDrinksCard), const Offset(300, 0), 1000);
    await tester.pumpAndSettle();
  }

  Future<void> tapFavourite() async {
    await tester.tap(find.byKey(favouriteIcon));
    await tester.pumpAndSettle();
  }

  Future<void> tapOverview() async {
    await tester.tap(find.byKey(tabOverview));
    await tester.pumpAndSettle();
  }

  Future<void> tapReviews() async {
    await tester.tap(find.byKey(tabReviews));
    await tester.pumpAndSettle();
  }

  Future<void> reviewPage() async {
    await tester.fling(find.byKey(reviewsPage), const Offset(0, -300), 1000);
    await tester.pumpAndSettle();
  }
}
