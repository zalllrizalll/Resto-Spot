import 'package:resto_spot/data/model/restaurant_detail.dart';

sealed class RestaurantDetailResultState {}

class RestaurantDetailNoneState extends RestaurantDetailResultState {}

class RestaurantDetailLoadingState extends RestaurantDetailResultState {}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  RestaurantDetailErrorState(this.error);
}

class RestaurantDetailSuccessState extends RestaurantDetailResultState {
  final RestaurantDetail data;

  RestaurantDetailSuccessState(this.data);
}
