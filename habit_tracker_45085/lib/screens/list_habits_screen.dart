import 'package:flutter/material.dart';

import '../components/habit_component.dart';
import '../firebaseConnection/authentication.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class ListHabitsScreen extends StatefulWidget {
  ListHabitsScreen({Key? key}) : super(key: key);

  @override
  _ListHabitsScreenState createState() => _ListHabitsScreenState();
}

class _ListHabitsScreenState extends State<ListHabitsScreen> {
  List<Map<String, dynamic>?> habitsList = [];
  var userInfo;
  final String? userUid = Authentication().getCurrentUser();

  DatabaseService databaseService = DatabaseService();

  Future<Map<String, dynamic>?> getUser() async {
    return await databaseService.getUserInfo(userUid!);
  }

  @override
  void initState() {
    super.initState();

    getUser().then((result) {
      setState(() {
        userInfo = result;
        habitsList = userInfo['selectedHabits'];
      });
    });
  }

  Future<List<Widget>> habits(BuildContext context) async {
    List<Widget> widgets = [];

    if (habitsList.isNotEmpty) {
      for (var h in habitsList) {
        var habit = await databaseService.getHabitById(h!['habitId']);
        var habitName = habit!['name'];
        var habitId = habit['id'];
        widgets.add(
          HabitComponent(
            text: habitName,
            image: '',
            habitId: habitId,
            onPressed: () {},
            isSlidable: true,
            isInHomeScreen: false,
            onDelete: () {
              // Remove the deleted habit from the habitsList
              setState(() {
                habitsList
                    .removeWhere((element) => element!['habitId'] == habitId);
              });
            },
          ),
        );
      }
    } else {
      widgets.add(
        SizedBox(
          height: 100,
        ),
      );
      widgets.add(
        Text(
          'Não tem hábitos',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: myTheme.primaryColor,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, 'mainScreen', (_) => false);
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
                  'Todos os seus hábitos',
                  style: TextStyle(
                    fontFamily: "RobotoMono",
                    fontWeight: FontWeight.normal,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 15),
                FutureBuilder<List<Widget>>(
                  future: habits(context),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
