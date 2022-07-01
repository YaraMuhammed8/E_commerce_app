import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/main/main_cubit.dart';

import '../components/products_grid_view.dart';
import 'categories_list_view.dart';
import 'custom_carousel_slider.dart';


class ProductsScreen extends StatelessWidget {
   ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return (cubit.homeModel != null && cubit.categoriesModel != null)
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomCarouselSlider(
                          banners: cubit.homeModel!.data!.banners),
                      const SizedBox(
                        height: 20,
                      ),
                      CategoriesListView(categories:cubit.categoriesModel!.data.categories,),
                      const SizedBox(
                        height: 20,
                      ),
                      ProductsGridView(
                        products: cubit.homeModel!.data!.products,
                      )
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}