import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/components/restaurant_card_widget.dart';
import 'package:resto_spot/components/search_widget.dart';
import 'package:resto_spot/provider/search/search_restaurant_provider.dart';
import 'package:resto_spot/routes/navigation.dart';
import 'package:resto_spot/static/search_restaurant_result_state.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search Restaurant',
              style: TextStyle(
                  color: CustomColors.white.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          backgroundColor: CustomColors.blue.color,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchWidget(
                  onQueryChanged: (query) {
                    context
                        .read<SearchRestaurantProvider>()
                        .fetchSearchRestaurant(query);
                  },
                  query: searchController.text),
            ),
            Expanded(
              child: Consumer<SearchRestaurantProvider>(
                  builder: (context, value, child) {
                return switch (value.resultState) {
                  SearchRestaurantLoadingState() => Center(
                      child: CircularProgressIndicator(),
                    ),
                  SearchRestaurantSuccessState(data: var restaurantList) =>
                    restaurantList.isEmpty
                        ? Center(
                            child: Text(
                              'No Results Found',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                        : ListView.builder(
                            itemCount: restaurantList.length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurantList[index];

                              return RestaurantCardWidget(
                                key: const ValueKey('restaurantCardSearch'),
                                  restaurant: restaurant,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Navigation.detailpage.name,
                                        arguments: restaurant.id);
                                  });
                            }),
                  SearchRestaurantErrorState(error: var message) => Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off_outlined,
                          color: Colors.red,
                          size: 50,
                        ),
                        SizedBox.square(dimension: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            message.contains('Failed host lookup') ||
                                    message.contains('SocketException')
                                ? 'No Internet Connection'
                                : message,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
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
            )
          ],
        ));
  }
}
