import 'package:flutter/material.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';
import 'package:resto_spot/services/sqlite_service.dart';

class FavouriteRestaurantProvider extends ChangeNotifier {
  final SqliteService _service;

  FavouriteRestaurantProvider(this._service);

  String _message = "";
  String get message => _message;

  List<RestaurantDetail>? _restaurantList;
  List<RestaurantDetail>? get restaurantList => _restaurantList;

  RestaurantDetail? _restaurant;
  RestaurantDetail? get restaurant => _restaurant;

  Future<void> addFavouriteRestaurant(RestaurantDetail data) async {
    try {
      final result = await _service.insertItem(data);

      final isError = result == 0;
      if (isError) {
        _message = 'Failed to add Favourite Restaurant';
        notifyListeners();
      } else {
        _message = 'Success to add Favourite Restaurant';
        notifyListeners();
      }
    } catch (e) {
      _message = 'Failed to add Favourite Restaurant';
      notifyListeners();
    }
  }

  Future<void> fetchFavouriteRestaurants() async {
    try {
      _restaurantList = await _service.getAllRestaurants();
      _message = 'Success to fetch all Favourite Restaurants';
      notifyListeners();
    } catch (e) {
      _message = 'Failed to fetch all Favourite Restaurants';
      notifyListeners();
    }
  }

  Future<void> fetchFavouriteRestaurantById(String id) async {
    try {
      _restaurant = await _service.getRestaurantById(id);
      _message = 'Success to fetch Favourite Restaurant';
      notifyListeners();
    } catch (e) {
      _message = 'Failed to fetch Favourite Restaurant';
      notifyListeners();
    }
  }

  Future<void> removeFavouriteRestaurantById(String id) async {
    try {
      final result = await _service.deleteItem(id);

      final isError = result == 0;
      if (isError) {
        _message = 'Failed to remove Favourite Restaurant';
        notifyListeners();
      } else {
        _message = 'Success to remove Favourite Restaurant';
        notifyListeners();
      }
    } catch (e) {
      _message = 'Failed to remove Favourite Restaurant';
      notifyListeners();
    }
  }
}
