import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/main/main_cubit.dart';
import 'package:shop_app/styles/colors/colors.dart';
import 'package:shop_app/styles/text_styles/app_text_styles.dart';
import 'package:shop_app/view/components/custom_button.dart';

import '../../../model/home_model.dart';
import '../components/no_image_founded.dart';
import 'components/discount_amount_container.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen(
      {Key? key, required this.product, this.isFromSearch = false})
      : super(key: key);
  Product product;
  bool isFromSearch;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.white),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.grey.shade300)
                      ]),
                  child: CarouselSlider(
                    items: product.images!
                        .map((e) => ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                              child: Image.network(
                                e,
                                height: 380,
                                width: double.infinity,
                                errorBuilder: noImageFounded,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        viewportFraction: 1,
                        height: 380,
                        enableInfiniteScroll: true,
                        initialPage: 0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (!isFromSearch && product.discount != 0)
                            DiscountAmountContainer(
                                amount: product.discount!.round()),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                cubit.changeFavouriteProduct(product.id);
                              },
                              alignment: Alignment.topRight,
                              icon: Icon(
                                (product.inFavorites!)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.primaryColor,
                              )),
                        ],
                      ),
                      Text(
                        product.name,
                        maxLines: 2,
                        style: AppTextStyles.title,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "${product.price.toStringAsFixed(2)} \u0024",
                            style: AppTextStyles.bodyText
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (!isFromSearch && product.discount != 0)
                            Text(
                              "${product.oldPrice!.toStringAsFixed(2)} \u0024",
                              style: AppTextStyles.subTitle.copyWith(
                                  decoration: TextDecoration.lineThrough),
                            )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        product.description,
                        maxLines: 3,
                        style: AppTextStyles.subTitle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //const Spacer(),
                      CustomButton(
                        onPress: () {},
                        text: "Add to cart",
                        icon: Icons.shopping_cart_outlined,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}