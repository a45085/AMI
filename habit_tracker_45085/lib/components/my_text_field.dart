import 'package:flutter/material.dart';

import '../theme/style.dart';

class MyTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textInputBackground),
                borderRadius: BorderRadius.circular(15.0)),
            prefixText: '  ',
            fillColor: textInputBackground,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: textInputTextColor)),
      ),
    );
  }
}
