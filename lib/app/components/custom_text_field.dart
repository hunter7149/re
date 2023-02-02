import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.label,
      this.validationText,
      this.controller,
      this.suffixIcon,
      this.suffixIconColor})
      : super(key: key);
  final String? label;
  final String? validationText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(
          suffixIcon,
          color: suffixIconColor,
        ),
        label: Text(label ?? ''),
        contentPadding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validationText;
        } else {
          return null;
        }
      },
    );
  }
}
