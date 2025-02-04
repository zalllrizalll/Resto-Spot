import 'package:flutter/material.dart';
import 'package:resto_spot/data/model/restaurant.dart';
import 'package:resto_spot/static/base_url.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;

  const RestaurantCardWidget(
      {super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 120,
                minHeight: 100,
                maxWidth: 120,
                maxHeight: 100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: restaurant.pictureId,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      '${BaseUrl.urlServer}/images/small/${restaurant.pictureId}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox.square(dimension: 12),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: restaurant.name,
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox.square(dimension: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.redAccent),
                    const SizedBox.square(dimension: 4),
                    Expanded(
                        child: Text(
                      restaurant.city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ))
                  ],
                ),
                const SizedBox.square(dimension: 20),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox.square(dimension: 4),
                    Expanded(
                      child: Text(
                        restaurant.rating.toString(),
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
