import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/main/main_cubit.dart';
import 'package:shop_app/styles/text_styles/app_text_styles.dart';

import 'components/products_grid_view.dart';

class CategoryProductsScreen extends StatefulWidget {
  CategoryProductsScreen(
      {Key? key, required this.categoryName, required this.categoryID})
      : super(key: key);
  String categoryName;
  int categoryID;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit mainCubit = MainCubit.get(context);
    mainCubit.getCategoryProducts(widget.categoryID);
  }

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
              title: Text(
                widget.categoryName,
                style: AppTextStyles.title,
              ),
              centerTitle: true,
            ),
            body: (state is GetCategoryProductsLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (cubit.categoryProductsResponse != null)
                    ? SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ProductsGridView(
                            products:
                                cubit.categoryProductsResponse!.data!.products,
                          ),
                        ),
                    )
                    : null);
      },
    );
  }
}