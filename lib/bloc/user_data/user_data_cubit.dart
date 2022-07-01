import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../model/login_response.dart';
import '../../model/uploaded_image.dart';
import '../../services/local/cache_helper.dart';
import '../../services/methods/show_toast.dart';
import '../../services/network/dio_helper.dart';
import '../../services/network/end_points.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());
  static UserDataCubit get(context) => BlocProvider.of(context);
  UserDataResponse? userDataResponse;
  void getUserData() {
    emit(GetUserDataLoading());
    DioHelper.getData(url: PROFILE, token: CacheHelper.getData(key: "token"))
        .then((value) {
      userDataResponse = UserDataResponse.fromJson(value.data);
      emit(GetUserDataSuccessful());
    }).catchError((error) {
      print("get user data error is ${error.toString()}");
      emit(GetUserDataError());
    });
  }

  UserDataResponse? updateProfileResponse;
  void updateProfile(
      {required String email,
      required String phone,
      required String name,
      required String image}) {
    emit(UpdateProfileLoading());
    DioHelper.putData(
            url: UPDATE_PROFILE,
            data: {
              "name": name,
              "email": email,
              "phone": phone,
              "image": image
            },
            token: CacheHelper.getData(key: "token"))
        .then((value) {
      updateProfileResponse = UserDataResponse.fromJson(value.data);
      if (updateProfileResponse!.status) {
        userDataResponse!.data!.name = name;
        userDataResponse!.data!.email = email;
        userDataResponse!.data!.phone = phone;
      } else {
        uploadedImage = null;
        showToastMessage(updateProfileResponse!.message!);
      }
      emit(UpdateProfileSuccessful());
    }).catchError((error) {
      uploadedImage = null;
      showToastMessage("sorry, an error has occurred");
      print("update profile error is ${error.toString()}");
      emit(UpdateProfileError());
    });
  }

  UploadedImage? uploadedImage;
  Future<void> uploadImage() async {
    String base64Image = "";
    final ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        base64Image = await value.readAsBytes().then((value) => base64Encode(value));
        uploadedImage = UploadedImage(base64Image: base64Image, file: File(value.path));
        emit(UploadImageSuccessful());
      }
    });
  }
}
