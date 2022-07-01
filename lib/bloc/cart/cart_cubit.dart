import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/model/carts.dart';
import 'package:shop_app/model/update_cart_response.dart';
import 'package:shop_app/services/local/cache_helper.dart';
import 'package:shop_app/services/methods/show_toast.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/services/network/end_points.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  UserCarts? userCarts;
  void getCarts() {
    emit(GetCartsLoading());
    DioHelper.getData(url: CART, token: CacheHelper.getData(key: "token"))
        .then((value) {
      userCarts = UserCarts.fromJson(value.data);
      emit(GetCartsSuccessful());
    }).catchError((error) {
      print("get carts error is ${error.toString()}");
      emit(GetCartsError());
    });
  }

  UpdateCartResponse? updateCartResponse;
  void updateCart(
      {required int cartID,
      required int oldQuantity,
      required int newQuantity}) {
    updateCartFromModel(quantity: newQuantity, cartID: cartID);
    emit(UpdateCartLoading());
    DioHelper.putData(
            url: "$UPDATE_CART$cartID",
            data: {"quantity": newQuantity},
            token: CacheHelper.getData(key: "token"))
        .then((value) {
      print(value.data);
      updateCartResponse = UpdateCartResponse.fromJson(value.data);
      if (!updateCartResponse!.status) {
        updateCartFromModel(quantity: oldQuantity, cartID: cartID);
        showToastMessage("sorry, an error has occurred");
      }
      emit(UpdateCartSuccessful());
    }).catchError((error) {
      updateCartFromModel(quantity: oldQuantity, cartID: cartID);
      showToastMessage("sorry, an error has occurred");
      print("update cart error is ${error.toString()}");
      emit(UpdateCartError());
    });
  }

  void updateCartFromModel({required int quantity, required int cartID}) {
    for (var element in userCarts!.data.cartItems) {
      if (element.id == cartID) {
        print(quantity);
        element.quantity = quantity;
      }
    }
  }
}
