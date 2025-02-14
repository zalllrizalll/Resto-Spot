import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/data/model/restaurant_detail.dart';
import 'package:resto_spot/pages/detail/favourite_icon_widget.dart';
import 'package:resto_spot/pages/detail/menus_drinks_card.dart';
import 'package:resto_spot/pages/detail/menus_food_card.dart';
import 'package:resto_spot/provider/detail/restaurant_detail_provider.dart';
import 'package:resto_spot/provider/favourite/favourite_icon_provider.dart';
import 'package:resto_spot/static/base_url.dart';
import 'package:resto_spot/static/restaurant_detail_result_state.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class BodyOfDetailPage extends StatefulWidget {
  final RestaurantDetail restaurant;
  const BodyOfDetailPage({super.key, required this.restaurant});

  @override
  State<BodyOfDetailPage> createState() => _BodyOfDetailPageState();
}

class _BodyOfDetailPageState extends State<BodyOfDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavouriteIconProvider(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.restaurant.pictureId,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      '${BaseUrl.urlServer}/images/medium/${widget.restaurant.pictureId}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          CustomColors.grey.color,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 15,
                    right: 15,
                    child: CircleAvatar(
                        backgroundColor: Colors.white54,
                        child: Consumer<RestaurantDetailProvider>(
                            builder: (_, value, child) {
                          return switch (value.resultState) {
                            RestaurantDetailLoadingState() => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            RestaurantDetailSuccessState(
                              data: var restaurant
                            ) =>
                              FavouriteIconWidget(restaurant: restaurant),
                            _ => const SizedBox()
                          };
                        })))
              ],
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
                          tag: widget.restaurant.name,
                          child: Text(
                            widget.restaurant.name,
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
                            widget.restaurant.rating.toString(),
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
                          child: Text(
                              '${widget.restaurant.address}, ${widget.restaurant.city}',
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
                    widget.restaurant.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox.square(dimension: 16),
                  Text(
                    'Foods',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox.square(dimension: 4),
                  MenusFoodCard(restaurant: widget.restaurant),
                  const SizedBox.square(dimension: 16),
                  Text(
                    'Drinks',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox.square(dimension: 4),
                  MenusDrinksCard(restaurant: widget.restaurant)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
