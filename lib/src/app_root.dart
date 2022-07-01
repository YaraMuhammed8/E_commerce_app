import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cart/cart_cubit.dart';
import 'package:shop_app/bloc/user_data/user_data_cubit.dart';

import '../bloc/login/login_cubit.dart';
import '../bloc/main/main_cubit.dart';
import '../bloc/register/register_cubit.dart';
import '../styles/themes/light_theme.dart';
import '../view/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => UserDataCubit()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
