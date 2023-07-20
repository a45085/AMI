import 'package:flutter/material.dart';

import '../theme/style.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50, //height of button
        width: 320, //width of button
        child: TextButton(
            style: myButtonStyle,
            onPressed: onPressed,
            child: Text(text,
                style: TextStyle(
                    fontFamily: "RobotoMono",
                    fontWeight: FontWeight.normal,
                    fontSize: 14))));
  }
}
