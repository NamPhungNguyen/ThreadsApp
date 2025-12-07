import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final TextInputAction? textInputAction;
  final double? height;
  final EdgeInsets? contentPadding;
  final TextEditingController controller;
  final bool obscureText;
  const CommonTextField({
    super.key,
    this.hintText,
    this.textInputAction,
    this.height = 68.0,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        textInputAction: textInputAction,
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: contentPadding,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
