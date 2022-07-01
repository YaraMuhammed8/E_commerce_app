import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/user_data/user_data_cubit.dart';
import 'package:shop_app/services/methods/validate_email.dart';
import 'package:shop_app/styles/colors/colors.dart';
import 'package:shop_app/view/components/custom_button.dart';
import 'package:shop_app/view/components/custom_profile_image.dart';
import '../../../../styles/text_styles/app_text_styles.dart';
import '../../components/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataCubit, UserDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UserDataCubit.get(context);
        nameController.text = cubit.userDataResponse!.data!.name;
        emailController.text = cubit.userDataResponse!.data!.email;
        phoneController.text = cubit.userDataResponse!.data!.phone;
        imageController.text = cubit.userDataResponse!.data!.image;
        return Scaffold(
          appBar: AppBar(
            title: Text("Shoopy"),
          ),
          body: (cubit.userDataResponse == null)
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Edit profile", style: AppTextStyles.headline),
                        if (state is UpdateProfileLoading)
                          const Center(child: LinearProgressIndicator())
                        else ...[
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: (cubit.uploadedImage != null)
                                        ? CustomProfileImage(
                                            onPress: () {
                                              cubit.uploadImage().then((value) {
                                                if (cubit.uploadedImage !=
                                                    null) {
                                                  imageController.text = cubit
                                                      .uploadedImage!
                                                      .base64Image;
                                                }
                                              });
                                            },
                                            isFromFile: true,
                                            imageFile:
                                                cubit.uploadedImage!.file,
                                          )
                                        : CustomProfileImage(
                                            onPress: () {
                                              cubit.uploadImage().then((value) {
                                                if (cubit.uploadedImage !=
                                                    null) {
                                                  imageController.text = cubit
                                                      .uploadedImage!
                                                      .base64Image;
                                                }
                                              });
                                            },
                                            isFromFile: false,
                                            imageURL: cubit.userDataResponse!
                                                .data!.image)),
                                const SizedBox(height: 20),
                                const Divider(
                                  thickness: 1.5,
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    labelText: "Name",
                                    prefixIcon: Icons.person_outline,
                                    fillColor: AppColors.appBackgroundColor,
                                    validate: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "enter a name";
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(height: 10),
                                CustomTextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    labelText: "E-mail",
                                    hintText: "Enter your email",
                                    prefixIcon: Icons.email_outlined,
                                    fillColor: AppColors.appBackgroundColor,
                                    validate: (String? value) {
                                      validateEmail(value);
                                    }),
                                const SizedBox(height: 10),
                                CustomTextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    labelText: "Phone number",
                                    prefixIcon: Icons.phone_android,
                                    fillColor: AppColors.appBackgroundColor,
                                    validate: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "enter a phone";
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(height: 20),
                                CustomButton(
                                    onPress: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.updateProfile(
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            name: nameController.text,
                                            image: cubit
                                                .uploadedImage!.base64Image);
                                      }
                                    },
                                    text: "Edit")
                              ],
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
