import 'package:flutter/material.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/static/review_restaurant_result_state.dart';

class ReviewRestaurantProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  ReviewRestaurantProvider(this._apiServices);

  ReviewRestaurantResultState _resultState = ReviewRestaurantNoneState();

  ReviewRestaurantResultState get resultState => _resultState;

  Future<void> addReviewRestaurant(
      String idRestaurant, String name, String review) async {
    try {
      _resultState = ReviewRestaurantLoadingState();
      notifyListeners();

      final result = await _apiServices.addReview(idRestaurant, name, review);

      if (result.error) {
        _resultState = ReviewRestaurantErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = ReviewRestaurantSuccessState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = ReviewRestaurantErrorState(e.toString());
      notifyListeners();
    }
  }
}
