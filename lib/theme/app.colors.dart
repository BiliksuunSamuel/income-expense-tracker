import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff7F3DFF);
  static const Color blueColor = Color(0xff0077FF);
  static const Color orangeColor = Color(0xffFCAC12);
  static const Color greenColor = Color(0xff00A86B);
  static const Color redColor = Color(0xffFD3C4A);
  static Color bodyBackgroundColor = Colors.white70.withOpacity(0.95);
  static Color primaryFromOpacity({double opacity = 1}) {
    return Color.fromRGBO(255, 255, 255, opacity);
  }
}
