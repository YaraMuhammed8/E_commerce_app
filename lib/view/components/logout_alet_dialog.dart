import 'package:flutter/material.dart';

import '../../services/local/cache_helper.dart';
import '../../services/methods/navigation.dart';
import '../login_screen.dart';

void showLogoutAlertDialog(context){
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content:
        const Text("Do you want to logout from your account?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                CacheHelper.removeData(key: "token").then((value) {
                  navigateAndNotBack(context, LoginScreen());
                });
              },
              child: const Text("Logout")),
        ],
      ));
}