import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int _indexNavigation = 0;

  int get indexNavigation => _indexNavigation;

  set setIndexNavigation(int value) {
    _indexNavigation = value;
    notifyListeners();
  }
}
