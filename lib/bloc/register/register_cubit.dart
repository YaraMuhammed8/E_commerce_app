import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/model/login_response.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/services/network/end_points.dart';

import '../../model/uploaded_image.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserDataResponse? registerResponse;

  void userRegister(
      {required String email,
      required String password,
      required String phone,
      required String name,
      required String image}) {
    emit(RegisterLoading());
    DioHelper.postData(url: REGISTER, data: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "image": image
    }).then((value) {
      print(value.data);
      registerResponse = UserDataResponse.fromJson(value.data);
      emit(RegisterSuccessful(registerResponse!));
    }).catchError((error) {
      print("register error is ${error.toString()}");
      emit(RegisterError());
    });
  }

  UploadedImage? uploadedImage;
  Future<UploadedImage> uploadImage() async {
    String base64Image = "";
    final ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        base64Image =
            await value.readAsBytes().then((value) => base64Encode(value));
        uploadedImage =
            UploadedImage(base64Image: base64Image, file: File(value.path));
        emit(UploadImageSuccessful());
      }
    });
    return uploadedImage!;
  }
}