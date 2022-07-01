import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/model/login_response.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/services/network/end_points.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserDataResponse? loginResponse;
  void userLogin({required String email, required String password}) {
    emit(LoginLoading());
    DioHelper.postData(url: LOGIN, data: {"email": email, "password": password})
        .then((value) {
      print(value.data);
      loginResponse = UserDataResponse.fromJson(value.data);
      emit(LoginSuccessful(loginResponse!));
    }).catchError((error) {
      print("login error is ${error.toString()}");
      emit(LoginError());
    });
  }
}
