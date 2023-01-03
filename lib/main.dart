import 'package:flutter/material.dart';
import 'package:simple_note/screens/splash_screen.dart';
import 'package:simple_note/values/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.colorPrimarySwatch,
        appBarTheme: const AppBarTheme(
          color: AppColors.appBarColor,
          iconTheme: IconThemeData(
            color: AppColors.iconsColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.iconsColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
