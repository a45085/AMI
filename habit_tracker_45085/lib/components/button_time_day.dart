import 'package:flutter/material.dart';

import '../theme/style.dart';

class ButtonTimeDay extends StatefulWidget {
  final Function(String) onTimeOfDaySelected;
  final bool
      isInFormClass; // Boolean variable to indicate whether it's in the form class

  const ButtonTimeDay({
    Key? key,
    required this.onTimeOfDaySelected,
    required this.isInFormClass,
  });

  @override
  _ButtonTimeDayState createState() => _ButtonTimeDayState();
}

class _ButtonTimeDayState extends State<ButtonTimeDay> {
  List<String> calendarItems = [
    'Diários',
    'Manhã',
    'Tarde',
    'Noite',
  ];

  int selectedButtonIndex = -1;

  @override
  void initState() {
    super.initState();
    selectedButtonIndex = getSelectedButtonIndex();
  }

  int getSelectedButtonIndex() {
    if (widget.isInFormClass) {
      return 0; // Select the "Diários" button by default in the form class
    } else {
      int currentHour = DateTime.now().hour;
      int sel = 0;

      if (currentHour >= 6 && currentHour < 12) {
        sel = 1; // Morning
      } else if (currentHour >= 12 && currentHour < 20) {
        sel = 2; // Afternoon
      } else {
        sel = 3; // Night
      }
      return sel;
    }
  }

  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var i = 0; i < 4; i++) {
      ButtonStyle buttonStyle = i == selectedButtonIndex
          ? homePageButtonStyle.copyWith(
              backgroundColor: MaterialStateProperty.all(myTheme.primaryColor),
            )
          : homePageButtonStyle;

      widgets.add(
        Column(
          children: [
            TextButton(
              style: buttonStyle,
              onPressed: () {
                setState(() {
                  selectedButtonIndex = i;
                });
                widget.onTimeOfDaySelected(calendarItems[i]);
              },
              child: Text(
                calendarItems[i],
                style: TextStyle(
                  fontFamily: "RobotoMono",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: i == selectedButtonIndex ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    );
  }
}
