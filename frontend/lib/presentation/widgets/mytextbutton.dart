import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color textColor;
  final Color backgroundColor;

  const MyTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.textColor, required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 110,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
