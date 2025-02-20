import 'dart:convert';

import 'package:resto_spot/data/model/restaurant.dart';

RestaurantListResponse restaurantListResponseFromJson(String str) =>
    RestaurantListResponse.fromJson(json.decode(str));

class RestaurantListResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: json["restaurants"] != null
            ? List<Restaurant>.from(
                json["restaurants"].map((x) => Restaurant.fromJson(x)))
            : <Restaurant>[],
      );
}
