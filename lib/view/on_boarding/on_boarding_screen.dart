import 'package:flutter/material.dart';
import 'package:shop_app/services/local/cache_helper.dart';
import 'package:shop_app/services/methods/navigation.dart';
import 'package:shop_app/view/on_boarding/page_view_item.dart';
import 'package:shop_app/view/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../styles/colors/colors.dart';

class OnBoardingContent {
  String imgPath;
  String text;
  OnBoardingContent({required this.imgPath, required this.text});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingContent> content = [
    OnBoardingContent(
        imgPath: "assets/images/choose.png",
        text: "You can choose products as you want and add them in a cart"),
    OnBoardingContent(
        imgPath: "assets/images/payment.png",
        text: "You can pay the cost by several payment methods"),
    OnBoardingContent(
        imgPath: "assets/images/delivery.png",
        text: "we deliver to you the purchases where you want"),
  ];

  PageController onBoardController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              finishOnBoarding();
            },
            child: Text(
              "SKIP",
              style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: onBoardController,
                onPageChanged: (index) {
                  setState(() {
                    if (index == content.length - 1) {
                      isLast = true;
                    } else {
                      isLast = false;
                    }
                  });
                },
                itemBuilder: (context, index) => PageViewItem(
                  content: content[index],
                ),
                itemCount: content.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SmoothPageIndicator(
              count: content.length,
              controller: onBoardController,
              effect: const WormEffect(
                dotColor: Colors.grey,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isLast == true) {
            finishOnBoarding();
          } else {
            onBoardController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn);
          }
        },
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  void finishOnBoarding() {
    CacheHelper.saveData(key: "onBoarding", value: true);
    navigateAndNotBack(context, LoginScreen());
  }
}