import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/main/main_cubit.dart';

import '../../../services/methods/navigation.dart';
import '../components/no_image_founded.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return (cubit.categoriesModel != null)
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.categoriesModel!.data.categories.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      navigateWithBack(
                          context,
                          CategoryProductsScreen(
                            categoryName: cubit
                                .categoriesModel!.data.categories[index].name,
                            categoryID: cubit
                                .categoriesModel!.data.categories[index].id,
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                  cubit.categoriesModel!.data.categories[index]
                                      .image,
                                  height: 100,
                                  width: 100,
                                  errorBuilder: noImageFounded)),
                          const SizedBox(width: 10),
                          Text(cubit
                              .categoriesModel!.data.categories[index].name),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}