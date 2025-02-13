import 'package:flutter/material.dart';

class FavouriteIconProvider extends ChangeNotifier {
  bool _isFavourite = false;

  bool get isFavourite => _isFavourite;

  set isFavourite(bool value) {
    _isFavourite = value;
    notifyListeners();
  }
}
