import 'package:mocktail/mocktail.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/data/model/review_restaurant_response.dart';
import 'package:resto_spot/provider/reviews/review_restaurant_provider.dart';
import 'package:resto_spot/static/review_restaurant_result_state.dart';
import 'package:test/test.dart';

class MockReviewRestaurant extends Mock implements ApiServices {}

void main() {
  late MockReviewRestaurant mockApiService;
  late ReviewRestaurantProvider reviewRestaurantProvider;

  setUp(() {
    mockApiService = MockReviewRestaurant();
    reviewRestaurantProvider = ReviewRestaurantProvider(mockApiService);
  });

  group('Review Restaurant Provider Test', () {
    test('should have an initial state of ReviewRestaurantNoneState', () async {
      expect(reviewRestaurantProvider.resultState,
          isA<ReviewRestaurantNoneState>());
    });

    test('should return a list of review when API call is successful',
        () async {
      final mockResponse = ReviewRestaurantResponse(
        error: false,
        message: "success",
        customerReviews: [],
      );

      when(() => mockApiService.addReview("1", "yasmin", "mantap"))
          .thenAnswer((_) async => mockResponse);

      await reviewRestaurantProvider.addReviewRestaurant(
          "1", "yasmin", "mantap");

      expect(reviewRestaurantProvider.resultState,
          isA<ReviewRestaurantSuccessState>());
    });

    test('should an error state when API call fails', () async {
      when(() => mockApiService.addReview("1", "yasmin", "mantap"))
          .thenThrow(Exception('Failed to add review'));

      await reviewRestaurantProvider.addReviewRestaurant(
          "1", "yasmin", "mantap");

      expect(reviewRestaurantProvider.resultState, isA<ReviewRestaurantErrorState>());
    });
  });
}
