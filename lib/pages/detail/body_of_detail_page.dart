import 'package:flutter/material.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';
import 'package:resto_spot/pages/detail/menus_drinks_card.dart';
import 'package:resto_spot/pages/detail/menus_food_card.dart';
import 'package:resto_spot/static/base_url.dart';

class BodyOfDetailPage extends StatelessWidget {
  final RestaurantDetail restaurant;
  const BodyOfDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: restaurant.pictureId,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                '${BaseUrl.urlServer}/images/medium/${restaurant.pictureId}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox.square(dimension: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Hero(
                        tag: restaurant.name,
                        child: Text(
                          restaurant.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox.square(dimension: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox.square(dimension: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.redAccent,
                    ),
                    const SizedBox.square(dimension: 4),
                    Expanded(
                        child: Text('${restaurant.address}, ${restaurant.city}',
                            style: Theme.of(context).textTheme.bodySmall)),
                  ],
                ),
                const SizedBox.square(dimension: 16),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox.square(dimension: 4),
                Text(
                  restaurant.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox.square(dimension: 16),
                Text(
                  'Foods',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox.square(dimension: 4),
                MenusFoodCard(restaurant: restaurant),
                const SizedBox.square(dimension: 16),
                Text(
                  'Drinks',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox.square(dimension: 4),
                MenusDrinksCard(restaurant: restaurant)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
