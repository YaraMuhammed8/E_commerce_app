import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/services/local/cache_helper.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/src/app_root.dart';
import 'bloc/bloc_observer.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  BlocOverrides.runZoned(
    () => runApp(const AppRoot()),
    blocObserver: MyBlocObserver(),
  );
}