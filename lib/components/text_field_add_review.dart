import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_spot/provider/detail/restaurant_detail_provider.dart';
import 'package:resto_spot/provider/reviews/review_restaurant_provider.dart';
import 'package:resto_spot/style/colors/custom_colors.dart';

class TextFieldAddReview extends StatelessWidget {
  final String idRestaurant;
  const TextFieldAddReview({super.key, required this.idRestaurant});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController reviewController = TextEditingController();

    void submitReview() {
      final reviewProvider = context.read<ReviewRestaurantProvider>();
      final detailProvider = context.read<RestaurantDetailProvider>();
      reviewProvider
          .addReviewRestaurant(
              idRestaurant, nameController.text, reviewController.text)
          .then((_) {
        detailProvider.fetchDetailRestaurant(idRestaurant);
        Navigator.pop(context);
      });
    }

    return AlertDialog(
      title: const Text('Add Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const ValueKey('nameReview'),
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          const SizedBox.square(dimension: 4),
          TextField(
            key: const ValueKey('descReview'),
            maxLines: 5,
            controller: reviewController,
            decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          )
        ],
      ),
      actions: [
        TextButton(
          key: const ValueKey('buttonBatal'),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Batal',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          key: const ValueKey('buttonSimpan'),
          onPressed: submitReview,
          child: Text(
            'Simpan',
            style: TextStyle(
              color: CustomColors.blue.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
