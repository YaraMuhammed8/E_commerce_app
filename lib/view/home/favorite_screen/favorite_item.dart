import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/main/main_cubit.dart';
import 'package:shop_app/styles/text_styles/app_text_styles.dart';
import '../../../../model/home_model.dart';
import '../../../../styles/colors/colors.dart';
import '../../components/no_image_founded.dart';
import '../components/discount_amount_container.dart';

class FavoriteItem extends StatelessWidget {
  FavoriteItem({Key? key, required this.product}) : super(key: key);
  Product product;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return Container(
          height: 100,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(product.image,
                      height: 100, width: 100, errorBuilder: noImageFounded)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.title,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text("${product.price.toStringAsFixed(2)} \u0024",
                            style: AppTextStyles.bodyText
                                .copyWith(color: AppColors.primaryColor)),
                        const SizedBox(
                          width: 10,
                        ),
                        if (product.discount != 0)
                          Text("${product.oldPrice!.toStringAsFixed(2)} \u0024",
                              style: AppTextStyles.subTitle.copyWith(
                                  decoration: TextDecoration.lineThrough)),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (product.discount != 0)
                    DiscountAmountContainer(amount: product.discount!.round()),
                  IconButton(
                    onPressed: () {
                      cubit.changeFavouriteProduct(product.id);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
