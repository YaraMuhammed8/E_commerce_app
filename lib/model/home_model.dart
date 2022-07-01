class HomeModel {
  HomeModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null) ? HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  HomeData({
    required this.banners,
    required this.products,
    required this.ad,
  });
  late final List<ShopBanner> banners;
  late final List<Product> products;
  late final String ad;

  HomeData.fromJson(Map<String, dynamic> json) {
    banners =
        List.from(json['banners']).map((e) => ShopBanner.fromJson(e)).toList();
    products =
        List.from(json['products']).map((e) => Product.fromJson(e)).toList();
    ad = json['ad'];
  }
}

class ShopBanner {
  ShopBanner({
    required this.id,
    required this.image,
  });
  late final int id;
  late final String image;

  ShopBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Product {
  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });
  late final int id;
  late double price;
  late double? oldPrice;
  late double? discount;
  late String image;
  late String name;
  late String description;
  late List<String>? images;
  late bool? inFavorites;
  late bool? inCart;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = double.parse(json['price'].toString());
    oldPrice = (json['old_price'] != null)
        ? double.parse(json['old_price'].toString())
        : null;
    discount = (json['discount'] != null)
        ? double.parse(json['discount'].toString())
        : null;
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = (json['images'] != null)
        ? List.castFrom<dynamic, String>(json['images'])
        : null;
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
