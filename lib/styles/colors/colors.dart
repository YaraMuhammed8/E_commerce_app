import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xffFA9335);
  static Color secondPrimaryColor = const Color(0xff424478);
  // 0xff2551AB
  // 0xffEF7C8E
  static Color appBackgroundColor = Colors.grey.shade50;

  static MaterialColor appPrimarySwatch = MaterialColor(
    0xffFA9335,
    <int, Color>{
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor
    },
  );
}