import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/login/login_cubit.dart';
import 'package:shop_app/services/methods/navigation.dart';
import 'package:shop_app/styles/text_styles/app_text_styles.dart';
import 'package:shop_app/view/home/home_layout.dart';
import '../services/local/cache_helper.dart';
import '../services/methods/show_toast.dart';
import '../styles/colors/colors.dart';
import 'components/custom_button.dart';
import 'components/custom_text_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoginSuccessful) {
          if (state.loginResponse.status) {
            CacheHelper.saveData(
                    key: "token", value: state.loginResponse.data!.token)
                .then((value) {
              navigateAndNotBack(context, HomeLayout());
            });
          } else {
            showToastMessage(state.loginResponse.message!);
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login", style: AppTextStyles.headline),
                    Text("login to see products and make your purchases",
                        style: AppTextStyles.subTitle),
                    const SizedBox(height: 20),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              labelText: "E-mail",
                              hintText: "Enter your email",
                              prefixIcon: Icons.email_outlined,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "enter an email";
                                } else if (value.length > 5 &&
                                    value.contains('@') &&
                                    value.endsWith('.com')) {
                                  return null;
                                } else {
                                  return "enter a valid email";
                                }
                              },
                            ),
                            const SizedBox(height: 20),
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
                            (state is LoginLoading)
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    onPress: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.userLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    text: "Login")
                          ],
                        )),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Don't have an account?",
                        style: AppTextStyles.bodyText,
                      ),
                      TextButton(
                        child: Text("Register Now",
                            style: AppTextStyles.bodyText
                                .copyWith(color: AppColors.primaryColor)),
                        onPressed: () {
                          navigateAndNotBack(context, RegisterScreen());
                        },
                      )
                    ]),
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
