import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF5D5FEF);
  static const Color secondary = Color(0xFF8F65F6);
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;
  static const Color black12 = Colors.black12;
  static const Color black = Colors.black;
  static const Color shadow = Colors.black45;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
