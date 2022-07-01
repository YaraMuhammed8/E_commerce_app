import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  TextEditingController controller;
  Function? onSubmit;
  Color? fillColor;
  SearchField(
      {Key? key,
      required this.controller,
      required this.onSubmit,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.grey.shade800),
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        filled: true,
        fillColor: fillColor ?? const Color(0xffF3F5F9),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: Colors.grey.shade600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}