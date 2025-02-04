import 'package:flutter/material.dart';

enum CustomColors {
  blue('Blue', Colors.blue),
  white('White', Colors.white),
  grey('Grey', Colors.white54);

  const CustomColors(this.name, this.color);

  final String name;
  final Color color;
}
