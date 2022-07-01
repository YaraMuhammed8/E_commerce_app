import 'package:shop_app/model/home_model.dart';

class   CategoryProductsResponse{
  late final bool status;
  late final CategoryProductsResponseData? data;
  CategoryProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = CategoryProductsResponseData.fromJson(json['data']);
  }
}
class CategoryProductsResponseData{
  late final List<Product> products;
  CategoryProductsResponseData.fromJson(Map<String, dynamic> json) {
    products = List.from(json["data"]).map((e) =>Product.fromJson(e)).toList();
  }
}