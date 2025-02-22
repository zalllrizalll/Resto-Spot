import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/pages/detail/body_of_detail_page.dart';
import 'package:resto_spot/pages/reviews/review_page.dart';
import 'package:resto_spot/provider/detail/restaurant_detail_provider.dart';
import 'package:resto_spot/static/restaurant_detail_result_state.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class DetailPage extends StatefulWidget {
  final String idRestaurant;
  const DetailPage({super.key, required this.idRestaurant});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchDetailRestaurant(widget.idRestaurant);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Detail Restaurant',
                style: TextStyle(
                    color: CustomColors.white.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            backgroundColor: CustomColors.blue.color,
            bottom: TabBar(
                labelColor: CustomColors.white.color,
                unselectedLabelColor: CustomColors.grey.color,
                indicatorColor: CustomColors.white.color,
                tabs: [
                  Tab(
                    key: const ValueKey('tabOverview'),
                    text: 'Overview',
                  ),
                  Tab(
                    key: const ValueKey('tabReviews'),
                    text: 'Reviews',
                  ),
                ]),
          ),
          body: TabBarView(children: [
            Consumer<RestaurantDetailProvider>(
                builder: (context, value, child) {
              return switch (value.resultState) {
                RestaurantDetailLoadingState() => Center(
                    child: CircularProgressIndicator(),
                  ),
                RestaurantDetailSuccessState(data: var restaurant) =>
                  BodyOfDetailPage(
                    key: const ValueKey('bodyOfDetailPage'),
                    restaurant: restaurant),
                RestaurantDetailErrorState(error: var message) => Center(
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
                      SizedBox.square(dimension: 16),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<RestaurantDetailProvider>()
                              .fetchDetailRestaurant(widget.idRestaurant);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
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
            ReviewPage(
              key: const ValueKey('reviewPage'),
              idRestaurant: widget.idRestaurant)
          ])),
    );
  }
}
