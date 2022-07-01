import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cart/cart_cubit.dart';
import 'package:shop_app/styles/text_styles/app_text_styles.dart';
import '../../../../model/carts.dart';
import '../../../../styles/colors/colors.dart';
import '../../components/no_image_founded.dart';

class CartItem extends StatelessWidget {
  CartItem({Key? key, required this.cart}) : super(key: key);
  Cart cart;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10) ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(cart.product.image,
                      height: 100, width: 100, errorBuilder: noImageFounded)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            cart.product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.title,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        IconButton(onPressed: (){},icon: const Icon(Icons.delete_outline,color: Colors.grey,),)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${cart.product.price.toStringAsFixed(2)} \u0024",
                        style: AppTextStyles.bodyText
                            .copyWith(color: AppColors.primaryColor)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (cart.quantity > 0) {
                              cubit.updateCart(
                                  cartID: cart.id,
                                  oldQuantity: cart.quantity,
                                  newQuantity: cart.quantity - 1);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.secondPrimaryColor
                                    .withOpacity(0.1)),
                            child: Transform.translate(
                              offset: const Offset(0,-5),
                              child: Icon(
                                Icons.minimize,
                                color: AppColors.secondPrimaryColor,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        Text(cart.quantity.toString()),
                        GestureDetector(
                          onTap: () {
                            cubit.updateCart(
                                cartID: cart.id,
                                oldQuantity: cart.quantity,
                                newQuantity: cart.quantity + 1);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.secondPrimaryColor
                                      .withOpacity(0.1)),
                            child: Icon(
                              Icons.add,
                              color: AppColors.secondPrimaryColor,
                              size: 25,
                            ),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
