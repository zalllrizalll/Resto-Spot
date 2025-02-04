import 'package:resto_spot/data/model/customer_review.dart';

sealed class ReviewRestaurantResultState {}

class ReviewRestaurantNoneState extends ReviewRestaurantResultState {}

class ReviewRestaurantLoadingState extends ReviewRestaurantResultState {}

class ReviewRestaurantErrorState extends ReviewRestaurantResultState {
  final String error;

  ReviewRestaurantErrorState(this.error);
}

class ReviewRestaurantSuccessState extends ReviewRestaurantResultState {
  final List<CustomerReview> data;

  ReviewRestaurantSuccessState(this.data);
}
