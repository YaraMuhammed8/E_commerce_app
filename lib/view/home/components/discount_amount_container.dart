import 'package:flutter/material.dart';
import '../../../../styles/colors/colors.dart';

class DiscountAmountContainer extends StatelessWidget {
  DiscountAmountContainer({Key? key, required this.amount}) : super(key: key);
  int amount;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.secondPrimaryColor.withOpacity(0.1)),
      child: Text(
        "- $amount %",
        style: TextStyle(color: AppColors.secondPrimaryColor),
      ),
    );
  }
}