import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/main/main_cubit.dart';
import 'package:shop_app/services/methods/navigation.dart';
import 'package:shop_app/styles/colors/colors.dart';

import '../../../../model/home_model.dart';
import '../../components/no_image_founded.dart';
import '../product_details_screen.dart';
import 'discount_amount_container.dart';

class ItemProduct extends StatelessWidget {
  ItemProduct({Key? key, required this.product}) : super(key: key);
  Product product;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return GestureDetector(
          onTap: () {
            navigateWithBack(context, ProductDetailsScreen(product: product));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (product.discount != 0)
                            DiscountAmountContainer(
                              amount: product.discount!.round(),
                            ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                cubit.changeFavouriteProduct(product.id);
                              },
                              icon: Icon(
                                (product.inFavorites == true)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              ))
                        ],
                      ),
                      Center(
                        child: Image.network(product.image,
                            height: 120, errorBuilder: noImageFounded),
                      ),
                      Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text("${product.price.toStringAsFixed(2)} \u0024",
                              style: TextStyle(color: AppColors.primaryColor)),
                          const SizedBox(width: 10),
                          if (product.discount != 0)
                            Text(
                                "${product.oldPrice!.toStringAsFixed(2)} \u0024",
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      cubit.changeCartProduct(product.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        (product.inCart!)
                            ? Icons.remove_shopping_cart_outlined
                            : Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
