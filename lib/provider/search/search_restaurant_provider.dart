import 'package:flutter/material.dart';
import 'package:resto_spot/data/api/api_services.dart';
import 'package:resto_spot/static/search_restaurant_result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  SearchRestaurantProvider(this._apiServices);

  SearchRestaurantResultState _resultState = SearchRestaurantNoneState();

  SearchRestaurantResultState get resultState => _resultState;

  Future<void> fetchSearchRestaurant(String query) async {
    if (query.isEmpty) {
      _resultState = SearchRestaurantNoneState();
      notifyListeners();
      return;
    }

    try {
      _resultState = SearchRestaurantLoadingState();
      notifyListeners();

      final result = await _apiServices.searchRestaurant(query);

      if (result.error) {
        _resultState = SearchRestaurantErrorState(result.error.toString());
        notifyListeners();
      } else {
        _resultState = SearchRestaurantSuccessState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = SearchRestaurantErrorState(e.toString());
      notifyListeners();
    }
  }
}
