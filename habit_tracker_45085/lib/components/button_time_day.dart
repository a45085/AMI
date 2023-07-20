import 'package:flutter/material.dart';
import 'package:habit_tracker_45085/utils/utils.dart';

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
      return int.parse(getSelectedButton()[1]);
    }
  }

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
                widget.onTimeOfDaySelected(calendarItems[i]);
                setState(() {
                  selectedButtonIndex = i;
                });
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
