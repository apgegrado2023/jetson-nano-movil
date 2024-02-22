import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color color;
  const CustomTextButton(
      {Key? key, this.onPressed, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
