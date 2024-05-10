import 'package:flutter/material.dart';
import 'package:vivid/src/constants/film_industry_words.dart';
import 'package:vivid/src/constants/colors.dart';
import 'package:vivid/src/features/authentication/controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vivid_colors.ttPrimaryColor,
      body: Center(
        child: SplashScreenController(),
      ),
    );
  }
}
