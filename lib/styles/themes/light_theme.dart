import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors/colors.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: "jannah",
    primarySwatch: AppColors.appPrimarySwatch,
    scaffoldBackgroundColor: AppColors.appBackgroundColor,
    iconTheme: IconThemeData(color: AppColors.primaryColor),
    appBarTheme: AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: AppColors.appBackgroundColor),
        backgroundColor: AppColors.appBackgroundColor,
        iconTheme: IconThemeData(color: AppColors.primaryColor)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 30));
