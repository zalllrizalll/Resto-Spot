import 'dart:convert';

import 'package:resto_spot/data/model/customer_review.dart';

RestaurantDetail restaurantDetailFromJson(String str) => RestaurantDetail.fromJson(json.decode(str));

class RestaurantDetail {
    String id;
    String name;
    String description;
    String city;
    String address;
    String pictureId;
    List<Category> categories;
    Menus menus;
    double rating;
    List<CustomerReview> customerReviews;

    RestaurantDetail({
        required this.id,
        required this.name,
        required this.description,
        required this.city,
        required this.address,
        required this.pictureId,
        required this.categories,
        required this.menus,
        required this.rating,
        required this.customerReviews,
    });

    factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );
}

class Category {
    String name;

    Category({
        required this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );
}

class Menus {
    List<Category> foods;
    List<Category> drinks;

    Menus({
        required this.foods,
        required this.drinks,
    });

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
    );
}