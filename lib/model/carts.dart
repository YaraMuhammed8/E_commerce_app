import 'home_model.dart';

class UserCarts {
  UserCarts({
    required this.status,
    required this.data,
    this.massage
  });
  late final bool status;
  late final String? massage;

  late final CartsData data;

  UserCarts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    massage = json['message'];
    data = CartsData.fromJson(json['data']);
  }
}

class CartsData {
  CartsData({
    required this.cartItems,
    required this.subTotal,
    required this.total,
  });
  late List<Cart> cartItems;
  late int subTotal;
  late int total;

  CartsData.fromJson(Map<String, dynamic> json) {
    cartItems = List.from(json['cart_items'])
        .map((e) => Cart.fromJson(e))
        .toList();
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class Cart {
  Cart({
    required this.id,
    required this.quantity,
    required this.product,
  });
  late final int id;
  late int quantity;
  late final Product product;

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']);
  }
}