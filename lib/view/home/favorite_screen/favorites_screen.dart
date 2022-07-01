import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/styles/text_styles/app_text_styles.dart';

import '../../../../bloc/main/main_cubit.dart';
import 'favorite_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return (cubit.favoritesModel == null)
            ? const Center(child: CircularProgressIndicator())
            : (cubit.favoritesModel!.data!.data.isEmpty)
                ? Center(
                    child: Text(
                      "No Favorites to show",
                      style: AppTextStyles.subTitle,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.favoritesModel!.data!.data.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) => FavoriteItem(
                          product:
                              cubit.favoritesModel!.data!.data[index].product),
                    ),
                  );
      },
    );
  }
}
