import 'package:flutter/material.dart';

Color buttonText = Colors.white;
Color greylettering = Color(0xFFA1A4B2);
Color textInputBackground = Color(0xFFF2F3F7);
Color textInputTextColor = Color(0xFFA1A4B2);
Color habitButton = Color(0xFFF2F3F7);
Color bottomNavIconsColor = Color(0xFF3F414E);

Color morningColor = Color(0xFFFBBC05);
Color afternoonColor = Color(0xFFF7CFB5);
Color nightColor = Color(0xFFC44F03);

final myTheme = ThemeData(
  primaryColor: Color(0xFFF89657),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'RobotoMono',
);

ButtonStyle myButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(buttonText),
  backgroundColor: MaterialStateProperty.all<Color>(myTheme.primaryColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(38.0),
    ),
  ),
);
ButtonStyle endSessionButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(buttonText),
  backgroundColor: MaterialStateProperty.all<Color>(myTheme.primaryColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
);

ButtonStyle homePageButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(textInputTextColor),
  backgroundColor: MaterialStateProperty.all<Color>(textInputBackground),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
  ),
);
ButtonStyle daysWeekButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(textInputTextColor),
  backgroundColor: MaterialStateProperty.all<Color>(textInputBackground),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
);
