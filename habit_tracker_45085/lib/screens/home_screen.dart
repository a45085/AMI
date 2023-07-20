import 'package:flutter/material.dart';
import 'package:habit_tracker_45085/firebaseConnection/authentication.dart';

import '../components/button_time_day.dart';
import '../components/days_component.dart';
import '../components/habit_component.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String? user = Authentication().getCurrentUser();
  DatabaseService databaseService = DatabaseService();
  String selectedDateText = "";
  String imagePath = "";
  var userInfo;
  int selectedTime = 0;
  int selectedDate = 0;
  String selectedTimeOfDay = "";
  String selectedWeekDay = "";
  bool isGoogle = false;

  Future<Map<String, dynamic>?> getUser() async {
    return await databaseService.getUserInfo(user!);
  }

  String getSelectedButton() {
    int currentHour = DateTime.now().hour;
    String sel = "Diários";

    if (currentHour >= 6 && currentHour < 12) {
      sel = "Manhã"; // Morning
    } else if (currentHour >= 12 && currentHour < 20) {
      sel = "Tarde"; // Afternoon
    } else {
      sel = "Noite"; // Night
    }
    return sel;
  }

  void handleDateSelected(DateTime selectedDate) {
    setState(() {
      selectedDateText = getHeaderText(selectedDate);
    });
  }

  void handleWeekDay(String selectedWeekDay) {
    setState(() {
      this.selectedWeekDay = selectedWeekDay;
    });
  }

  void handleTimeOfDaySelected(String selectedTime) {
    setState(() {
      selectedTimeOfDay = selectedTime;

      switch (selectedTime) {
        case "Diários": // day
          selectedTimeOfDay = 'Diários';
          imagePath = './assets/images/day.png';
          break;
        case 'Manhã': // morning
          selectedTimeOfDay = 'Manhã';
          imagePath = './assets/images/morning.png';
          break;
        case 'Tarde': // afternoon
          selectedTimeOfDay = 'Tarde';
          imagePath = './assets/images/day.png';
          break;
        case 'Noite': // night
          selectedTimeOfDay = 'Noite';
          imagePath = './assets/images/night.png';
          break;
        default:
          selectedTimeOfDay = 'Diários';
          imagePath = './assets/images/day.png';
      }
    });
  }

  Future<List<Widget>> habits(BuildContext context, String selectedWeekDay,
      String selectedTimeDay) async {
    List<Widget> widgets = [];
    List<Map<String, dynamic>> selectedHabits = userInfo['selectedHabits'];

    bool hasMatchingHabits =
        false; // Flag to check if there are matching habits

    if (selectedHabits.isNotEmpty) {
      for (int i = 0; i < selectedHabits.length; i++) {
        var habit =
            await databaseService.getHabitById(selectedHabits[i]['habitId']);
        var habitName = habit!['name'];
        var habitId = habit['id'];
        var habitWeekdays = selectedHabits[i]['weekdays'];
        var habitTime = selectedHabits[i]['time'];

        if (selectedTimeDay == "Diários" &&
            (habitWeekdays.contains(selectedWeekDay) ||
                habitWeekdays.isEmpty)) {
          widgets.add(
            HabitComponent(
              text: habitName,
              image: '',
              habitId: habitId,
              onPressed: () {},
              isSlidable: true,
              isInHomeScreen: true,
              onDelete: () {},
            ),
          );
          hasMatchingHabits = true; // Set the flag to true
        } else if ((habitWeekdays.contains(selectedWeekDay) ||
                habitWeekdays.isEmpty) &&
            (habitTime == selectedTimeOfDay || habitTime.isEmpty)) {
          widgets.add(
            HabitComponent(
              text: habitName,
              habitId: habitId,
              image: '',
              onPressed: () {},
              isSlidable: true,
              isInHomeScreen: true,
              onDelete: () {},
            ),
          );
          hasMatchingHabits = true; // Set the flag to true
        }
      }
    }

    if (!hasMatchingHabits) {
      widgets.add(
        SizedBox(
          height: 100,
        ),
      );
      widgets.add(
        Text(
          'Sem hábitos',
          style: TextStyle(
            fontFamily: "RobotoMono",
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),
      );
    }

    return widgets;
  }

  String currentMonthYear() {
    DateTime currentDate = DateTime.now();
    String month = currentDate.month.toString();
    String year = currentDate.year.toString();
    return '${getMonthName(month)} $year';
  }

  String getMonthName(String month) {
    switch (month) {
      case '1':
        return 'Janeiro';
      case '2':
        return 'Fevereiro';
      case '3':
        return 'Março';
      case '4':
        return 'Abril';
      case '5':
        return 'Maio';
      case '6':
        return 'Junho';
      case '7':
        return 'Julho';
      case '8':
        return 'Agosto';
      case '9':
        return 'Setembro';
      case '10':
        return 'Outubro';
      case '11':
        return 'Novembro';
      case '12':
        return 'Dezembro';
      default:
        return '';
    }
  }

  String getHeaderText(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();
    if (selectedDate.year == currentDate.year &&
        selectedDate.month == currentDate.month &&
        selectedDate.day == currentDate.day) {
      return 'Hoje';
    } else if (selectedDate.year == currentDate.year &&
        selectedDate.month == currentDate.month &&
        selectedDate.day == currentDate.day + 1) {
      return 'Amanhã';
    } else if (selectedDate.year == currentDate.year &&
        selectedDate.month == currentDate.month &&
        selectedDate.day == currentDate.day - 1) {
      return 'Ontem';
    } else {
      return 'Dia ${selectedDate.day.toString()}';
      // Customize this based on your requirements
    }
  }

  @override
  void initState() {
    super.initState();

    String selectedButton = getSelectedButton();
    handleTimeOfDaySelected(selectedButton);
    getUser().then((result) {
      setState(() {
        userInfo = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              'listHabits',
            );
          },
          icon: Icon(Icons.format_list_bulleted_rounded),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              Text(
                selectedDateText.isEmpty
                    ? getHeaderText(DateTime.now())
                    : selectedDateText,
                style: TextStyle(
                  fontFamily: "RobotoMono",
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 10),
              Text(
                currentMonthYear(),
                style: TextStyle(
                  fontFamily: "RobotoMono",
                  color: greylettering,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 15),
              DaysComponent(
                onDateSelected: handleDateSelected,
                onWeekDay: handleWeekDay,
              ),
              SizedBox(height: 10),
              Image.asset(
                imagePath,
                fit: BoxFit.fill,
                height: 180,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 10),
              ButtonTimeDay(
                onTimeOfDaySelected: handleTimeOfDaySelected,
                isInFormClass: false,
              ),
              FutureBuilder<List<Widget>>(
                future: habits(context, selectedWeekDay, selectedTimeOfDay),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('An error occurred: ${snapshot.error}');
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: snapshot.data ?? [],
                    );
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
