import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.textStyle,
    this.borderColor = Colors.grey,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextStyle? textStyle;
  final Color borderColor;
  final void Function(String text) onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      style: textStyle,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
