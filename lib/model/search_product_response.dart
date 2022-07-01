import 'package:shop_app/model/home_model.dart';

class   SearchProductsResponse{
  late final bool status;
  late final SearchProductsResponseData? data;
  SearchProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = SearchProductsResponseData.fromJson(json['data']);
  }
}
class SearchProductsResponseData{
  late final List<Product> resultProducts;
  SearchProductsResponseData.fromJson(Map<String, dynamic> json) {
    resultProducts = List.from(json["data"]).map((e) =>Product.fromJson(e)).toList();
  }
}