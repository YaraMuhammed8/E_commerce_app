import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/services/methods/navigation.dart';
import '../../../../model/categories_model.dart';
import '../../../../styles/colors/colors.dart';
import '../category_products_screen.dart';

class CategoriesListView extends StatelessWidget {
  CategoriesListView({Key? key, required this.categories}) : super(key: key);
  List<Category> categories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            navigateWithBack(
                context,
                CategoryProductsScreen(
                  categoryName: categories[index].name,
                  categoryID: categories[index].id,
                ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondPrimaryColor.withOpacity(0.1)),
            child: Text(
              categories[index].name,
              style: TextStyle(color: AppColors.secondPrimaryColor),
            ),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: categories.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
