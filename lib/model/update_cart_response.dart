import 'carts.dart';

class UpdateCartResponse {
  UpdateCartResponse({required this.status, required this.data, this.massage});
  late final bool status;
  late final String? massage;

  late final CartsData? data;

  UpdateCartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    massage = json['message'];
    data = CartsData.fromJson(json['data']);
  }
}

class CartData {
  CartData({
    required this.cart,
    required this.subTotal,
    required this.total,
  });
  late final Cart cart;
  late final int subTotal;
  late final int total;

  CartData.fromJson(Map<String, dynamic> json) {
    cart = Cart.fromJson(json["cart"]);
    subTotal = json['sub_total'];
    total = json['total'];
  }
}