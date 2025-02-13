import 'package:resto_spot/data/model/restaurant.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';

extension RestaurantDetailExtension on RestaurantDetail {
  Restaurant toRestaurant() {
    return Restaurant(
        id: id,
        name: name,
        description: description,
        pictureId: pictureId,
        city: city,
        rating: rating);
  }
}
