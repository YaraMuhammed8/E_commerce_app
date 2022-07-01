import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/register/register_cubit.dart';
import 'package:shop_app/view/components/custom_profile_image.dart';

import '../services/local/cache_helper.dart';
import '../services/methods/navigation.dart';
import '../services/methods/show_toast.dart';
import '../services/methods/validate_email.dart';
import '../styles/text_styles/app_text_styles.dart';
import 'components/custom_button.dart';
import 'components/custom_text_field.dart';
import 'home/home_layout.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is RegisterSuccessful) {
          if (state.registerResponse.status) {
            CacheHelper.saveData(
                    key: "token", value: state.registerResponse.data!.token)
                .then((value) {
              navigateAndNotBack(context, const HomeLayout());
            });
          } else {
            showToastMessage(state.registerResponse.message!);
          }
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Shoopy"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Register", style: AppTextStyles.headline),
                    Text("Register to see products and make your purchases",
                        style: AppTextStyles.subTitle),
                    const SizedBox(height: 20),
                    Center(
                        child: (cubit.uploadedImage != null)
                            ? CustomProfileImage(
                                onPress: () {
                                  cubit.uploadImage().then((value) {
                                    if (cubit.uploadedImage != null) {
                                      imageController.text =
                                          cubit.uploadedImage!.base64Image;
                                    }
                                  });
                                },
                                isFromFile: true,
                                imageFile: cubit.uploadedImage!.file,
                              )
                            : CustomProfileImage(
                                onPress: () {
                                  cubit.uploadImage().then((value) {
                                    if (cubit.uploadedImage != null) {
                                      imageController.text =
                                          cubit.uploadedImage!.base64Image;
                                    }
                                  });
                                },
                                isFromFile: false,
                                noimage: true)),
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
                        validate: (String? value) {
                          return validateEmail(value);
                        }),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: "Phone number",
                        prefixIcon: Icons.phone_android,
                        validate: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "enter a phone";
                          } else {
                            return null;
                          }
                        }),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: "Password",
                      hintText: "Enter your Password",
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "enter a password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    (state is RegisterLoading)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    image: imageController.text);
                              }
                            },
                            text: "Register")
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
