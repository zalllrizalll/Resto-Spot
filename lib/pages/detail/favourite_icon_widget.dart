import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';
import 'package:resto_spot/provider/favourite/favourite_icon_provider.dart';
import 'package:resto_spot/provider/favourite/favourite_restaurant_provider.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class FavouriteIconWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  const FavouriteIconWidget({super.key, required this.restaurant});

  @override
  State<FavouriteIconWidget> createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  @override
  void initState() {
    super.initState();
    final favouriteRestaurantProvider =
        context.read<FavouriteRestaurantProvider>();
    final favouriteIconWidget = context.read<FavouriteIconProvider>();

    Future.microtask(() async {
      await favouriteRestaurantProvider
          .fetchFavouriteRestaurantById(widget.restaurant.id);
      if (!mounted) return;
      final value = favouriteRestaurantProvider.restaurant == null
          ? false
          : favouriteRestaurantProvider.restaurant!.id == widget.restaurant.id;
      favouriteIconWidget.isFavourite = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final favouriteRestaurantProvider =
              context.read<FavouriteRestaurantProvider>();
          final favouriteIconWidget = context.read<FavouriteIconProvider>();

          final isFavourite = favouriteIconWidget.isFavourite;
          if (isFavourite) {
            await favouriteRestaurantProvider
                .removeFavouriteRestaurantById(widget.restaurant.id);
          } else {
            await favouriteRestaurantProvider
                .addFavouriteRestaurant(widget.restaurant);
          }

          favouriteIconWidget.isFavourite = !isFavourite;
          favouriteRestaurantProvider.fetchFavouriteRestaurants();
        },
        icon: Icon(
          context.watch<FavouriteIconProvider>().isFavourite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
        ),
        color: CustomColors.red.color);
  }
}
