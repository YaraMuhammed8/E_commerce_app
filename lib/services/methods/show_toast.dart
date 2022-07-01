import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void showToastMessage(String text){
  Fluttertoast.showToast(
      msg:text, backgroundColor: Colors.black45);}