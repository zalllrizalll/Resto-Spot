import 'package:mocktail/mocktail.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/data/model/search_restaurant_response.dart';
import 'package:resto_spot/provider/search/search_restaurant_provider.dart';
import 'package:resto_spot/static/search_restaurant_result_state.dart';
import 'package:test/test.dart';

class MockSearchRestaurant extends Mock implements ApiServices {}

void main() {
  late MockSearchRestaurant mockApiServices;
  late SearchRestaurantProvider searchRestaurantProvider;

  setUp(() {
    mockApiServices = MockSearchRestaurant();
    searchRestaurantProvider = SearchRestaurantProvider(mockApiServices);
  });

  group('Search Restaurant Provider Test', () {
    test('should have an initial state of SearchRestaurantNoneState', () async {
      expect(searchRestaurantProvider.resultState,
          isA<SearchRestaurantNoneState>());
    });

    test('should return a list of restaurant when API call is successful',
        () async {
      final mockResponse = SearchRestaurantResponse(
        error: false,
        founded: 4,
        restaurants: [],
      );

      when(() => mockApiServices.searchRestaurant('kafe'))
          .thenAnswer((_) async => mockResponse);

      await searchRestaurantProvider.fetchSearchRestaurant('kafe');

      expect(searchRestaurantProvider.resultState,
          isA<SearchRestaurantSuccessState>());
    });

    test('should return an error state when API call fails', () async {
      when(() => mockApiServices.searchRestaurant('kafe')).thenThrow(
          Exception('Failed to load search information about restaurant'));

      await searchRestaurantProvider.fetchSearchRestaurant('kafe');

      expect(searchRestaurantProvider.resultState,
          isA<SearchRestaurantErrorState>());
    });
  });
}
