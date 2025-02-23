import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/components/restaurant_card_widget.dart';
import 'package:resto_spot/data/model/restaurant_detail_extension.dart';
import 'package:resto_spot/provider/favourite/favourite_restaurant_provider.dart';
import 'package:resto_spot/routes/navigation.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FavouriteRestaurantProvider>().fetchFavouriteRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourite Restaurants',
          style: TextStyle(
            color: CustomColors.white.color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: CustomColors.blue.color,
      ),
      body: Consumer<FavouriteRestaurantProvider>(
          builder: (context, value, child) {
        final favouriteRestoList = value.restaurantList ?? [];

        return switch (favouriteRestoList.isNotEmpty) {
          true => ListView.builder(
              itemCount: favouriteRestoList.length,
              itemBuilder: (context, index) {
                final favouriteResto = favouriteRestoList[index];

                return RestaurantCardWidget(
                    key: const ValueKey('restaurantCardFavourite'),
                    restaurant: favouriteResto.toRestaurant(),
                    onTap: () {
                      Navigator.pushNamed(context, Navigation.detailpage.name,
                          arguments: favouriteResto.id);
                    });
              }),
          _ => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Results Found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            )
        };
      }),
    );
  }
}
