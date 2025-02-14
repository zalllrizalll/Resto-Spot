import 'package:flutter/material.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class MenusFoodCard extends StatelessWidget {
  final RestaurantDetail restaurant;
  const MenusFoodCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: restaurant.menus.foods.length,
          itemBuilder: (context, index) {
            final food = restaurant.menus.foods[index];

            return Card(
              color: CustomColors.blue.color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  food.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          }),
    );
  }
}
