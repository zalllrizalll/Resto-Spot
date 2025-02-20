import 'dart:convert';

import 'package:resto_spot/data/model/restaurant.dart';

SearchRestaurantResponse searchRestaurantFromJson(String str) =>
    SearchRestaurantResponse.fromJson(json.decode(str));

class SearchRestaurantResponse {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  SearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
