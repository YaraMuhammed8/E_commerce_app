import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shop_app/services/methods/navigation.dart';
import 'package:shop_app/styles/text_styles/app_text_styles.dart';
import 'package:shop_app/view/home/home_layout.dart';
import 'package:shop_app/view/login_screen.dart';
import 'package:shop_app/view/on_boarding/on_boarding_screen.dart';
import '../services/local/cache_helper.dart';
import '../styles/colors/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => navigateAndNotBack(context, chooseNextScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/bag.png",
              fit: BoxFit.cover,
              height: 150,
              width: 150,
            ),
            Text(
              "SHOPPY",
              style: AppTextStyles.headline.copyWith(
                  color: AppColors.secondPrimaryColor,),
            )
          ],
        ),
      ),
    );
  }

  Widget chooseNextScreen() {
    bool? onBoardingFinished = CacheHelper.getData(key: "onBoarding");
    String? userToken = CacheHelper.getData(key: "token");
    if (userToken != null) {
      return HomeLayout();
    } else if (onBoardingFinished != null && onBoardingFinished) {
      return LoginScreen();
    } else {
      return OnBoardingScreen();
    }
  }
}
