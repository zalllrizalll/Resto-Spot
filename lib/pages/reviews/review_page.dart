import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/components/text_field_add_review.dart';
import 'package:resto_spot/provider/detail/restaurant_detail_provider.dart';
import 'package:resto_spot/static/restaurant_detail_result_state.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class ReviewPage extends StatefulWidget {
  final String idRestaurant;
  const ReviewPage({
    super.key,
    required this.idRestaurant,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchDetailRestaurant(widget.idRestaurant);
    });
  }

  void _showAddReviewDialog() {
    showDialog(
      context: context,
      builder: (context) => TextFieldAddReview(
        idRestaurant: widget.idRestaurant,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<RestaurantDetailProvider>(
            builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => Center(
                child: CircularProgressIndicator(),
              ),
            RestaurantDetailSuccessState(data: var data) => ListView.builder(
                itemCount: data.customerReviews.length,
                itemBuilder: (context, index) {
                  final customerReview = data.customerReviews[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox.square(dimension: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  customerReview.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  customerReview.review,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
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
              )
          };
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            key: const ValueKey('buttonAddReview'),
            style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blue.color,
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: _showAddReviewDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: CustomColors.white.color),
                const SizedBox.square(dimension: 8),
                Text(
                  'Add Review',
                  style: TextStyle(
                    color: CustomColors.white.color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
