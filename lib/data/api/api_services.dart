import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resto_spot/data/model/restaurant_detail_response.dart';
import 'package:resto_spot/data/model/restaurant_list_response.dart';
import 'package:resto_spot/data/model/review_restaurant_response.dart';
import 'package:resto_spot/data/model/search_restaurant_response.dart';
import 'package:resto_spot/static/base_url.dart';

class ApiServices {
  Future<RestaurantListResponse> getListRestaurants() async {
    final response = await http.get(Uri.parse('${BaseUrl.urlServer}/list'));

    if (response.statusCode == 200) {
      return restaurantListResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load restaurant data');
    }
  }

  Future<RestaurantDetailResponse> getDetailRestaurant(
      String idRestaurant) async {
    final response =
        await http.get(Uri.parse('${BaseUrl.urlServer}/detail/$idRestaurant'));

    if (response.statusCode == 200) {
      return restaurantDetailResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load detail information for restaurant');
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse('${BaseUrl.urlServer}/search?q=$query'));

    if (response.statusCode == 200) {
      return searchRestaurantFromJson(response.body);
    } else {
      throw Exception('Failed to load search information about restaurant');
    }
  }

  Future<ReviewRestaurantResponse> addReview(
      String idRestaurant, String name, String review) async {
    final response = await http.post(
      Uri.parse('${BaseUrl.urlServer}/review'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"id": idRestaurant, "name": name, "review": review}),
    );

    if (response.statusCode == 201) {
      return reviewRestaurantResponseFromJson(response.body);
    } else {
      throw Exception('Failed to add review');
    }
  }
}
