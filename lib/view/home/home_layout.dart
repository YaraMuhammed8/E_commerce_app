import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cart/cart_cubit.dart';
import 'package:shop_app/bloc/main/main_cubit.dart';
import 'package:shop_app/bloc/user_data/user_data_cubit.dart';
import 'package:shop_app/services/methods/navigation.dart';
import 'package:shop_app/styles/colors/colors.dart';
import 'package:shop_app/view/home/search_screen.dart';

import 'cart_screen/carts_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MainCubit mainCubit = BlocProvider.of<MainCubit>(context);
    mainCubit
      ..getHomeData()
      ..getCategories()
      ..getFavorites();
    UserDataCubit userDataCubit = BlocProvider.of<UserDataCubit>(context);
    userDataCubit.getUserData();
    CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.getCarts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(
              "SHOPPY",
              style: TextStyle(color: AppColors.secondPrimaryColor),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateWithBack(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                  )),
              IconButton(
                  onPressed: () {
                    navigateWithBack(context, CartsScreen());
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  )),
            ],
          ),
          body: cubit.homeScreens[cubit.currentIndex],
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      spreadRadius: -20,
                      color: Colors.grey.shade300)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeCurrentIndex(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      activeIcon: Icon(Icons.home),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.grid_view),
                      activeIcon: Icon(Icons.grid_view_rounded),
                      label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border),
                      activeIcon: Icon(Icons.favorite),
                      label: "Favorites"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
