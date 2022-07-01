import 'package:flutter/material.dart';

import 'on_boarding_screen.dart';

// ignore: must_be_immutable
class PageViewItem extends StatelessWidget {
  OnBoardingContent content;
   PageViewItem({Key? key,required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset(content.imgPath)),
        Text(content.text,style: const TextStyle(fontSize: 22),),
      ],
    );
  }
}
