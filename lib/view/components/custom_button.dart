import 'package:flutter/material.dart';

import '../../styles/colors/colors.dart';


class CustomButton extends StatelessWidget {
  Function onPress;
  String text;
  IconData? icon;
  CustomButton({Key? key, required this.onPress, required this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor),
        child: MaterialButton(
          onPressed: () {
            onPress();
          },
          height: 60,
          minWidth: double.infinity,
          textColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 22),
              ),
              if(icon!=null)
              Icon(icon,color:Colors.white)
            ],
          ),
        ));
  }
}