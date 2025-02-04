import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/components/restaurant_card_widget.dart';
import 'package:resto_spot/provider/home/restaurant_list_provider.dart';
import 'package:resto_spot/routes/navigation.dart';
import 'package:resto_spot/static/restaurant_list_result_state.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resto Spot',
            style: TextStyle(
                color: CustomColors.white.color,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        backgroundColor: CustomColors.blue.color,
      ),
      body: Consumer<RestaurantListProvider>(builder: (context, value, child) {
        return switch (value.resultState) {
          RestaurantListLoadingState() => Center(
              child: CircularProgressIndicator(),
            ),
          RestaurantListSuccessState(data: var restaurantList) =>
            ListView.builder(
                itemCount: restaurantList.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurantList[index];

                  return RestaurantCardWidget(
                    onTap: () {
                      Navigator.pushNamed(context, Navigation.detailpage.name,
                          arguments: restaurant.id);
                    },
                    restaurant: restaurant,
                  );
                }),
          RestaurantListErrorState(error: var message) => Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50,
                ),
                SizedBox.square(dimension: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox.square(dimension: 8),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<RestaurantListProvider>()
                        .fetchRestaurantList();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Retry',
                  ),
                )
              ],
            )),
          _ => Center(
              child: Text(
                'No Results Found',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
        };
      }),
    );
  }
}
