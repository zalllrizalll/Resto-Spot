import 'package:resto_spot/data/model/restaurant.dart';

sealed class SearchRestaurantResultState {}

class SearchRestaurantNoneState extends SearchRestaurantResultState {}

class SearchRestaurantLoadingState extends SearchRestaurantResultState {}

class SearchRestaurantErrorState extends SearchRestaurantResultState {
  final String error;

  SearchRestaurantErrorState(this.error);
}

class SearchRestaurantSuccessState extends SearchRestaurantResultState {
  final List<Restaurant> data;

  SearchRestaurantSuccessState(this.data);
}
