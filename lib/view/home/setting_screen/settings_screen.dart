import 'package:flutter/material.dart';
import 'package:shop_app/services/methods/navigation.dart';
import 'package:shop_app/view/components/logout_alet_dialog.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  List<SettingItem> settingItems = [
    SettingItem(
        title: "Profile",
        icon: Icons.person_outline,
        onTap: (context) {
          navigateWithBack(context, EditProfileScreen());
        }),
    SettingItem(
        title: "Logout",
        icon: Icons.logout,
        onTap: showLogoutAlertDialog
    )
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => ListTile(
              leading: Icon(settingItems[index].icon),
              title: Text(settingItems[index].title),
              onTap: () {
                settingItems[index].onTap(context);
              },
            ),
        itemCount: settingItems.length);
  }
}

class SettingItem {
  IconData icon;
  String title;
  Function onTap;
  SettingItem({required this.title, required this.icon, required this.onTap});
}