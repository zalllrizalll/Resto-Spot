import 'package:mocktail/mocktail.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';
import 'package:resto_spot/data/model/restaurant_detail_response.dart';
import 'package:resto_spot/provider/detail/restaurant_detail_provider.dart';
import 'package:resto_spot/static/restaurant_detail_result_state.dart';
import 'package:test/test.dart';

class MockRestaurantDetail extends Mock implements ApiServices {}

void main() {
  late MockRestaurantDetail mockApiServices;
  late RestaurantDetailProvider restaurantDetailProvider;

  setUp(() {
    mockApiServices = MockRestaurantDetail();
    restaurantDetailProvider = RestaurantDetailProvider(mockApiServices);
  });

  group('Restaurant Detail Provider Test', () {
    test('should have an initial state of RestaurantDetailNoneState', () {
      expect(restaurantDetailProvider.resultState,
          isA<RestaurantDetailNoneState>());
    });

    test('should return a detail information of restaurant when API call is successful',
        () async {
      final mockResponse = RestaurantDetailResponse(
          error: false,
          message: "success",
          restaurant: RestaurantDetail(
            id: "1",
            name: "name",
            description: "description",
            city: "city",
            address: "address",
            pictureId: "pictureId",
            categories: [],
            menus: Menus(
              foods: [],
              drinks: [],
            ),
            rating: 4.5,
            customerReviews: [],
          ));

      when(() => mockApiServices.getDetailRestaurant("1"))
          .thenAnswer((_) async => mockResponse);

      await restaurantDetailProvider.fetchDetailRestaurant("1");

      expect(restaurantDetailProvider.resultState,
          isA<RestaurantDetailSuccessState>());
    });

    test('should return an error state when API call fails', () async {
      when(() => mockApiServices.getDetailRestaurant("1"))
      .thenThrow(
          Exception('Failed to load detail information for restaurant'));

      await restaurantDetailProvider.fetchDetailRestaurant("1");

      expect(restaurantDetailProvider.resultState, isA<RestaurantDetailErrorState>());
    });
  });
}
