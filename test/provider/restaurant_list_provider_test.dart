import 'package:mocktail/mocktail.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/data/model/restaurant_list_response.dart';
import 'package:resto_spot/provider/home/restaurant_list_provider.dart';
import 'package:resto_spot/static/restaurant_list_result_state.dart';
import 'package:test/test.dart';

class MockRestaurantList extends Mock implements ApiServices {}

void main() {
  late MockRestaurantList mockApiServices;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    mockApiServices = MockRestaurantList();
    restaurantListProvider = RestaurantListProvider(mockApiServices);
  });

  group('Restaurant List Provider Test', () {
    test('should have an initial state of RestauranListNoneState', () {
      expect(
          restaurantListProvider.resultState, isA<RestaurantListNoneState>());
    });

    test('should return a list of restaurant when API call is successful',
        () async {
      final mockResponse = RestaurantListResponse(
          error: false, message: "success", count: 20, restaurants: []);

      when(() => mockApiServices.getListRestaurants())
          .thenAnswer((_) async => mockResponse);

      await restaurantListProvider.fetchRestaurantList();

      expect(restaurantListProvider.resultState,
          isA<RestaurantListSuccessState>());
    });

    test('should return an error state when API call fails', () async {
      when(() => mockApiServices.getListRestaurants())
          .thenThrow(Exception('Failed to load restaurant data'));

      await restaurantListProvider.fetchRestaurantList();

      expect(restaurantListProvider.resultState, isA<RestaurantListErrorState>());
    });
  });
}