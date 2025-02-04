import 'package:flutter/material.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';

class MenusDrinksCard extends StatelessWidget {
  final RestaurantDetail restaurant;
  const MenusDrinksCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: restaurant.menus.drinks.length,
          itemBuilder: (context, index) {
            final drink = restaurant.menus.drinks[index];

            return Card(
              color: const Color.fromARGB(255, 149, 216, 255),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  drink.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          }),
    );
  }
}
