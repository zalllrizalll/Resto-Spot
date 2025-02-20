import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/pages/home/home_page.dart';
import 'package:resto_spot/provider/home/restaurant_list_provider.dart';
import 'package:resto_spot/static/restaurant_list_result_state.dart';

class MockRestaurantListProvider extends Mock implements RestaurantListProvider {}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  late MockRestaurantListProvider mockRestaurantListProvider;
  late Widget widget;

  setUp(() {
    HttpOverrides.global = MyHttpOverrides();

    mockRestaurantListProvider = MockRestaurantListProvider();

    when(() => mockRestaurantListProvider.resultState)
        .thenReturn(RestaurantListLoadingState());

    when(() => mockRestaurantListProvider.fetchRestaurantList())
        .thenAnswer((_) async {});

    widget = MaterialApp(
      home: ChangeNotifierProvider<RestaurantListProvider>(
        create: (_) => mockRestaurantListProvider,
        child: const HomePage(),
      ),
    );
  });

  group('Home Page Test', () {
    testWidgets('should display app bar with title "Resto Spot"', (tester) async {
      await tester.pumpWidget(widget);

      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      final textInAppBarFinder = find.descendant(of: appBarFinder, matching: find.byType(Text));
      final textInAppBar = tester.widget<Text>(textInAppBarFinder);
      expect(textInAppBar.data, 'Resto Spot');
    });

    testWidgets('should display loading indicator when in loading state', (tester) async {
      when(() => mockRestaurantListProvider.resultState)
          .thenReturn(RestaurantListLoadingState());

      await tester.pumpWidget(widget);

      final loadingIndicatorFinder = find.byType(CircularProgressIndicator);
      expect(loadingIndicatorFinder, findsOneWidget);
    });

    testWidgets('should display error message and retry button when in error state', (tester) async {
      const errorMessage = 'Failed to load data';
      when(() => mockRestaurantListProvider.resultState)
          .thenReturn(RestaurantListErrorState(errorMessage));

      await tester.pumpWidget(widget);

      final errorIconFinder = find.byIcon(Icons.error_outline);
      expect(errorIconFinder, findsOneWidget);

      final errorTextFinder = find.text(errorMessage);
      expect(errorTextFinder, findsOneWidget);

      final retryButtonFinder = find.text('Retry');
      expect(retryButtonFinder, findsOneWidget);
    });
  });
}