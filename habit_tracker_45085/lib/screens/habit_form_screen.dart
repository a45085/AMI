import 'package:flutter/material.dart';

import '../components/button_time_day.dart';
import '../components/my_button.dart';
import '../firebaseConnection/authentication.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class HabitFormScreen extends StatefulWidget {
  const HabitFormScreen({Key? key}) : super(key: key);

  @override
  _HabitFormScreenState createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends State<HabitFormScreen> {
  List<String> daysOfWeek = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  List<String> selectedDays = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
  String selectedTimeOfDay = "Diários";
  String description = '';

  final String? userId = Authentication().getCurrentUser();
  DatabaseService databaseService = DatabaseService();

  void handleTimeDayName(String selectedTime) {
    setState(() {
      selectedTimeOfDay = selectedTime;
    });
  }

  void showAddHabitDialog(BuildContext context, bool added) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(''),
        content: Text(added
            ? 'Hábito adicionado com sucesso.'
            : 'Não foi possível adicionar o hábito. \nVerifique se este já não existe.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (added) {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'mainScreen', (_) => false);
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final habit = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    final habitId = habit[0] as String;
    final habitName = habit[1] as String;

    bool isInFormClass = true; // Track whether it's in the form class

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: myTheme.primaryColor,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Criar novo hábito',
                  style: TextStyle(
                    fontFamily: "RobotoMono",
                    fontWeight: FontWeight.normal,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: myTheme.primaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(
                        30,
                        0,
                        30,
                        0,
                      ),
                      leading: Image.asset(
                        './assets/images/icon_smartphone.png',
                        height: 40,
                        width: 40,
                      ),
                      title: Text(
                        habitName,
                        style: TextStyle(
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: habitButton,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  height: 130.0,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Descrição',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Dias da semana',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "RobotoMono",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 1,
                          color: textInputTextColor,
                        ),
                        SizedBox(height: 15),
                        Wrap(
                          spacing: -17,
                          children: List.generate(daysOfWeek.length, (index) {
                            final day = daysOfWeek[index];
                            final isSelected = selectedDays.contains(day);

                            return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedDays.remove(day);
                                  } else {
                                    selectedDays.add(day);
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(5),
                                side: BorderSide(
                                    color: isSelected
                                        ? myTheme.primaryColor
                                        : textInputTextColor),
                                elevation: 0,
                                backgroundColor: isSelected
                                    ? myTheme.primaryColor
                                    : Colors.white,
                                foregroundColor:
                                    isSelected ? Colors.white : Colors.grey,
                              ),
                              child: Text(day),
                            );
                          }),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          'Altura do Dia',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "RobotoMono",
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 1,
                          color: textInputTextColor,
                        ),
                        SizedBox(height: 15),
                        ButtonTimeDay(
                          onTimeOfDaySelected: handleTimeDayName,
                          isInFormClass:
                              isInFormClass, // Pass the boolean variable
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                MyButton(
                  text: "Criar Hábito",
                  onPressed: () async {
                    bool added = await databaseService.addHabitToUser(
                      userId!,
                      habitId,
                      description,
                      false,
                      selectedDays,
                      selectedTimeOfDay,
                    );

                    showAddHabitDialog(context, added);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
