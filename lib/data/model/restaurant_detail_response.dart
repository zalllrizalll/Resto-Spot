import 'dart:convert';

import 'package:resto_spot/data/model/restaurant_detail.dart';

RestaurantDetailResponse restaurantDetailResponseFromJson(String str) =>
    RestaurantDetailResponse.fromJson(json.decode(str));

class RestaurantDetailResponse {
  bool error;
  String message;
  RestaurantDetail restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );
}
