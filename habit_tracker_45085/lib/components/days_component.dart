import 'package:flutter/material.dart';

import '../theme/style.dart';
import '../utils/utils.dart';

class DaysComponent extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final Function(String) onWeekDay;
  const DaysComponent(
      {super.key, required this.onDateSelected, required this.onWeekDay});

  @override
  _DaysComponentState createState() => _DaysComponentState();
}

class _DaysComponentState extends State<DaysComponent> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < daysWeek.length; i++) {
      DateTime day =
          currentDate.subtract(Duration(days: currentDate.weekday - i - 1));
      String formattedDate = day.day.toString();
      ButtonStyle buttonStyle = i == currentDate.weekday - 1
          ? homePageButtonStyle.copyWith(
              backgroundColor: MaterialStateProperty.all(myTheme.primaryColor),
            )
          : homePageButtonStyle;

      widgets.add(
        Column(
          children: [
            SizedBox(
              width: 42,
              child: TextButton(
                style: buttonStyle,
                onPressed: () {
                  widget.onDateSelected(day);
                  widget.onWeekDay(daysWeek[i]);
                  setState(() {
                    currentDate = day;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      daysWeek[i],
                      style: TextStyle(
                        fontFamily: "RobotoMono",
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: i == currentDate.weekday - 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontFamily: "RobotoMono",
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: i == currentDate.weekday - 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
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
