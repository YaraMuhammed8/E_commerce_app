import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/category_products.dart';
import 'package:shop_app/model/change_cart_response.dart';
import 'package:shop_app/model/change_fav_response.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/favourites_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/services/local/cache_helper.dart';
import 'package:shop_app/services/methods/show_toast.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/services/network/end_points.dart';
import '../../model/search_product_response.dart';
import '../../view/home/categories_screen.dart';
import '../../view/home/favorite_screen/favorites_screen.dart';
import '../../view/home/products_screen/products_Screen.dart';
import '../../view/home/setting_screen/settings_screen.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> homeScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(CurrentIndexChanged());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(GetHomeDataLoading());
    DioHelper.getData(
      url: GET_HOME_DATA,
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(GetHomeDataSuccessful());
    }).catchError((error) {
      print("getting home data error is${error.toString()}");
      emit(GetHomeDataError());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(GetCategoriesLoading());
    DioHelper.getData(url: CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetCategoriesSuccessful());
    }).catchError((error) {
      print("getting categories error is ${error.toString()}");
      emit(GetCategoriesError());
    });
  }

  ChangeFavProductResponse? changeFavResponse;

  void changeFavouriteProduct(int productID) {
    changeProductFavFromModel(productID);
    emit(ChangeFavouriteProductLoading());
    DioHelper.postData(
            url: FAVORITE,
            data: {"product_id": productID},
            token: CacheHelper.getData(key: "token"))
        .then((value) {
      changeFavResponse = ChangeFavProductResponse.fromJson(value.data);
      if (!changeFavResponse!.status) {
        changeProductFavFromModel(productID);
        showToastMessage("sorry, an error has occurred");
      } else {
        getFavorites();
      }
      emit(ChangeFavouriteProductSuccessful());
    }).catchError((error) {
      changeProductFavFromModel(productID);
      showToastMessage("sorry, an error has occurred");
      print("change fav product error is ${error.toString()}");
      emit(ChangeFavouriteProductError());
    });
  }

// to change emmidiatly in the UI
  void changeProductFavFromModel(int productID) {
    for (var element in homeModel!.data!.products) {
      if (element.id == productID) {
        element.inFavorites = !element.inFavorites!;
      }
    }
    if (categoryProductsResponse != null) {
      for (var element in categoryProductsResponse!.data!.products) {
        if (element.id == productID) {
          element.inFavorites = !element.inFavorites!;
        }
      }
    }
    if (searchProductsResponse != null) {
      for (var element in searchProductsResponse!.data!.resultProducts) {
        if (element.id == productID) {
          element.inFavorites = !element.inFavorites!;
        }
      }
    }
  }

  FavoritesModel? favoritesModel;
  getFavorites() {
    emit(GetFavouritesLoading());
    DioHelper.getData(url: FAVORITE, token: CacheHelper.getData(key: "token"))
        .then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(GetFavouritesSuccessful());
    }).catchError((error) {
      print("get favourites error is ${error.toString()}");
      emit(GetFavouritesError());
    });
  }

  CategoryProductsResponse? categoryProductsResponse;

  getCategoryProducts(int categoryID) {
    emit(GetCategoryProductsLoading());
    DioHelper.getData(
            url: "$CATEGORY_PRODUCTS$categoryID",
            token: CacheHelper.getData(key: "token"))
        .then((value) {
      categoryProductsResponse = CategoryProductsResponse.fromJson(value.data);
      emit(GetCategoryProductsSuccessful());
    }).catchError((error) {
      showToastMessage("sorry, an error has occurred");
      print("get category products error is ${error.toString()}");
      emit(GetCategoryProductsError());
    });
  }

  SearchProductsResponse? searchProductsResponse;
  void searchProduct(String text) {
    emit(SearchProductLoading());
    DioHelper.postData(
            url: SEARCH_PRODUCT,
            data: {"text": text},
            token: CacheHelper.getData(key: "token"))
        .then((value) {
      print(value.data);
      searchProductsResponse = SearchProductsResponse.fromJson(value.data);
      emit(SearchProductSuccessful());
    }).catchError((error) {
      print("search product  error is ${error.toString()}");
      showToastMessage("sorry, an error has occurred");
      emit(SearchProductError());
    });
  }

  ChangeCartResponse? changeCartResponse;
  void changeCartProduct(int productID) {
    changeProductCartFromModel(productID);
    emit(ChangeCartProductLoading());
    DioHelper.postData(
            url: CART,
            data: {"product_id": productID},
            token: CacheHelper.getData(key: "token"))
        .then((value) {
      changeCartResponse = ChangeCartResponse.fromJson(value.data);
      if (!changeCartResponse!.status) {
        changeProductCartFromModel(productID);
        showToastMessage("sorry, an error has occurred");
      } else {
        //getFavorites();
      }
      emit(ChangeCartProductSuccessful());
    }).catchError((error) {
      changeProductCartFromModel(productID);
      showToastMessage("sorry, an error has occurred");
      print("change cart product error is ${error.toString()}");
      emit(ChangeCartProductError());
    });
  }

  void changeProductCartFromModel(int productID) {
    for (var element in homeModel!.data!.products) {
      if (element.id == productID) {
        element.inCart = !element.inCart!;
      }
    }
    if (categoryProductsResponse != null) {
      for (var element in categoryProductsResponse!.data!.products) {
        if (element.id == productID) {
          element.inCart = !element.inCart!;
        }
      }
    }
  }
}