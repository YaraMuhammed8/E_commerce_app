import 'home_model.dart';

class FavoritesModel {
  FavoritesModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final FavoritesModelData? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null)
        ? FavoritesModelData.fromJson(json['data'])
        : null;
  }
}

class FavoritesModelData {
  FavoritesModelData({
    required this.data,
  });
  late final List<FavouriteData> data;

  FavoritesModelData.fromJson(Map<String, dynamic> json) {
    data =
        List.from(json['data']).map((e) => FavouriteData.fromJson(e)).toList();
  }
}

class FavouriteData {
  FavouriteData({
    required this.id,
    required this.product,
  });
  late final int id;
  late final Product product;

  FavouriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}