import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/pages/home/home_page.dart';
import 'package:resto_spot/provider/home/restaurant_list_provider.dart';

class MockApiService extends Mock implements ApiServices {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockApiService mockApiService;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    mockApiService = MockApiService();
    restaurantListProvider = RestaurantListProvider(mockApiService);
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider<RestaurantListProvider>.value(
        value: restaurantListProvider,
        child: const HomePage(),
      ),
    );
  }

  group('HomePage Integration Test', () {
    testWidgets('Verify initial loading state', (WidgetTester tester) async {
      when(() => mockApiService.getListRestaurants())
          .thenAnswer((_) async => Future.delayed(const Duration(seconds: 1)));

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Verify success state with restaurant list',
        (WidgetTester tester) async {

      when(() => mockApiService.getListRestaurants());

      await tester.pumpWidget(createTestWidget());

      // Menunggu state berubah dari loading ke success
      await tester.pumpAndSettle();

      expect(find.text('Restaurant 1'), findsOneWidget);
      expect(find.text('Restaurant 2'), findsOneWidget);
    });

    testWidgets('Verify error state with retry button',
        (WidgetTester tester) async {
      when(() => mockApiService.getListRestaurants())
          .thenThrow(Exception('Failed to load data'));

      await tester.pumpWidget(createTestWidget());

      await tester.pumpAndSettle();

      expect(find.text('Failed to load data'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);

      // Simulasikan klik tombol Retry
      when(() => mockApiService.getListRestaurants());

      await tester.tap(find.text('Retry'));
      await tester.pump();

      // Pastikan loading muncul lagi
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
