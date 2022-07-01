import 'package:flutter/material.dart';
import '../../styles/colors/colors.dart';

class CustomTextFormField extends StatefulWidget {
  TextEditingController controller;
  TextInputType keyboardType;
  String? labelText;
  bool isPassword;
  String? hintText;
  IconData? prefixIcon;
  Color? fillColor;
  String? Function(String?)? validate;
  CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      this.isPassword = false,
      this.labelText,
      this.hintText,
      this.prefixIcon,
      this.fillColor,
      this.validate})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: (widget.isPassword && hidePassword),
      validator: widget.validate,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        filled: true,
        fillColor: widget.fillColor??Colors.grey.shade100,
        prefixIcon: Icon(widget.prefixIcon),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: (widget.isPassword)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(hidePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined))
            : null,
      ),
    );
  }
}
