import 'dart:io';

import 'package:flutter/material.dart';

import '../../styles/colors/colors.dart';

class CustomProfileImage extends StatelessWidget {
  CustomProfileImage(
      {Key? key,
      required this.onPress,
      required this.isFromFile,
      this.imageURL,
      this.imageFile,
      this.noimage = false})
      : super(key: key);
  Function onPress;
  bool isFromFile;
  bool noimage;
  String? imageURL;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      CircleAvatar(
        radius: 60,
        backgroundColor: Colors.grey.shade100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: (noimage)
              ? const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey,
                )
              : (isFromFile)
                  ? Image.file(
                      imageFile!,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, object, spaceTrace) => const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey,
                      ),
                    )
                  : Image.network(
                      imageURL!,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, object, spaceTrace) => const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
        ),
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
              radius: 20, backgroundColor: AppColors.appBackgroundColor),
          IconButton(
              onPressed: () {
                onPress();
              },
              icon: const CircleAvatar(
                radius: 18,
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    ]);
  }
}
