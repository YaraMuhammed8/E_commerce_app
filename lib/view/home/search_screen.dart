import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/main/main_cubit.dart';
import 'package:shop_app/services/methods/navigation.dart';
import 'package:shop_app/styles/text_styles/app_text_styles.dart';
import 'package:shop_app/view/components/search_field.dart';
import 'package:shop_app/view/home/product_details_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchKeyController = TextEditingController();

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
              title: Row(
                children: [
                  Expanded(
                    child: SearchField(
                        controller: searchKeyController,
                        fillColor: Colors.white,
                        onSubmit: (String searchKey) {
                          cubit.searchProduct(searchKey);
                        }),
                  ),
                  TextButton(
                      onPressed: () {
                        cubit.searchProduct(searchKeyController.text);
                      },
                      child: const Text("SEARCH"))
                ],
              ),
            ),
            body: (state is SearchProductLoading)
                ? const Center(child: CircularProgressIndicator())
                : (cubit.searchProductsResponse != null  && cubit.searchProductsResponse!.status)
                    ? (cubit.searchProductsResponse!.data!.resultProducts
                            .isEmpty)
                        ? Center(
                            child: Text(
                              "No products are found",
                              style: AppTextStyles.subTitle,
                            ),
                          )
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(20),
                            itemCount: cubit.searchProductsResponse!.data!
                                .resultProducts.length,
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  height: 30,
                                )),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    navigateWithBack(
                                        context,
                                        ProductDetailsScreen(
                                          product: cubit.searchProductsResponse!
                                              .data!.resultProducts[index],
                                          isFromSearch: true,
                                        ));
                                  },
                                  child: Text(
                                      cubit.searchProductsResponse!.data!
                                          .resultProducts[index].name,
                                      style: AppTextStyles.bodyText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ))
                    : null);
      },
    );
  }
}
