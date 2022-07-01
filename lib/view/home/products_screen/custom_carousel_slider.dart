import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/home_model.dart';

import '../../components/no_image_founded.dart';

class CustomCarouselSlider extends StatelessWidget {
  CustomCarouselSlider({Key? key, required this.banners}) : super(key: key);
  List<ShopBanner> banners;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: banners
            .map((e) => ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(e.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: noImageFounded),
                ))
            .toList(),
        options: CarouselOptions(
            viewportFraction: 1,
            height: 180,
            autoPlay: true,
            enableInfiniteScroll: true,
            initialPage: 0,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn));
  }
}
