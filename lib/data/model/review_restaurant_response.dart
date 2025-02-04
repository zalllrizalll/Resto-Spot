import 'dart:convert';

import 'package:resto_spot/data/model/customer_review.dart';

ReviewRestaurantResponse reviewRestaurantResponseFromJson(String str) => ReviewRestaurantResponse.fromJson(json.decode(str));

String reviewRestaurantResponseToJson(ReviewRestaurantResponse data) => json.encode(data.toJson());

class ReviewRestaurantResponse {
    bool error;
    String message;
    List<CustomerReview> customerReviews;

    ReviewRestaurantResponse({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    factory ReviewRestaurantResponse.fromJson(Map<String, dynamic> json) => ReviewRestaurantResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}