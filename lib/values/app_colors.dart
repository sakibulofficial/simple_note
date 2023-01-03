import 'package:flutter/material.dart';

final Map<int, Color> colorSwatch = {
  50: const Color.fromRGBO(231, 24, 74, .1),
  100: const Color.fromRGBO(231, 24, 74, .2),
  200: const Color.fromRGBO(231, 24, 74, .3),
  300: const Color.fromRGBO(231, 24, 74, .4),
  400: const Color.fromRGBO(231, 24, 74, .5),
  500: const Color.fromRGBO(231, 24, 74, .6),
  600: const Color.fromRGBO(231, 24, 74, .7),
  700: const Color.fromRGBO(231, 24, 74, .8),
  800: const Color.fromRGBO(231, 24, 74, .9),
  900: const Color.fromRGBO(231, 24, 74, 1),
};

abstract class AppColors {
  static MaterialColor colorPrimarySwatch =
      MaterialColor(0xFFE7184A, colorSwatch);
  static const Color pageBackgroundColor = Color(0xFF121212);
  static const Color primaryColor = Color(0xFFE7184A);
  static const Color appBarColor = Color(0xFFD9D9D9);
  // D9D9D9
  static const Color higlitTextcolor = Color(0xFF000000);

  static const Color tileTextColor = Color(0xFF000000);
  static const Color textColor = Color(0xFF363636);
  static const Color iconsColor = Color(0xFF363636);

  static const Color textColorTwo = Color(0xFFF3F3F3);
  static const Color bottomBarColor = Color(0xFFD9D9D9);
  static const Color backgroundTextColor = Color.fromARGB(255, 136, 136, 136);

  static List<int> cardBackBackgroundColors = [
    0xFF6C80EB,
    0xFFEB7D6C,
    0xFFE7184A,
    0xFF000000,
  ];
}
