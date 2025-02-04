import 'package:resto_spot/data/model/restaurant.dart';

sealed class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState(this.error);
}

class RestaurantListSuccessState extends RestaurantListResultState {
  final List<Restaurant> data;

  RestaurantListSuccessState(this.data);
}
