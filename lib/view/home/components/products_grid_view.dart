import 'package:flutter/material.dart';
import 'package:shop_app/model/home_model.dart';

import 'item_product.dart';

class ProductsGridView extends StatelessWidget {
  ProductsGridView({Key? key, required this.products}) : super(key: key);
  List<Product> products;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1/1.42,
      children: List.generate(
          products.length,
          (index) => ItemProduct(product: products[index])
      ),
    );
  }
}