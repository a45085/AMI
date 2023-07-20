import 'package:flutter/material.dart';

import '../theme/style.dart';

class ButtonWithImageComponent extends StatelessWidget {
  const ButtonWithImageComponent({
    Key? key,
    required this.text,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final String image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: SizedBox(
          height: 130,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: habitButton,
            elevation: 5,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: Image.asset(
                      image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: "RobotoMono",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
