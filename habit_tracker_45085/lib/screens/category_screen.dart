import 'package:flutter/material.dart';

import '../components/habit_component.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  DatabaseService databaseService = DatabaseService();

  Future<List<Widget>> habits(BuildContext context, String categoryId) async {
    List<Widget> widgets = [];
    Map<String, dynamic>? category =
        await databaseService.getCategoryById(categoryId);
    var habitsId = category!['habitos'];

    List<Map<String, dynamic>?> habits = [];
    for (var h in habitsId) {
      habits.add(await databaseService.getHabitById(h));
    }

    if (habits.isNotEmpty) {
      for (var h in habits) {
        var habitId = h!['id'];
        var habitName = h['name'];
        widgets.add(
          HabitComponent(
            text: habitName,
            image: '',
            habitId: habitId,
            onPressed: () {
              Navigator.pushNamed(
                context,
                'habitForm',
                arguments: [habitId, habitName],
              );
            },
            isSlidable: false,
            isInHomeScreen: false,
            onDelete: () {},
          ),
        );
      }
    } else {
      // Handle the case when the list is null
      widgets.add(
        SizedBox(
          height: 100,
        ),
      );
      widgets.add(
        Text(
          'Não há categorias disponíveis',
          style: TextStyle(
              fontFamily: "RobotoMono",
              fontWeight: FontWeight.normal,
              fontSize: 15),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    final categoryName = category[1] as String;

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
              child: Column(children: [
            Text(
              categoryName,
              style: TextStyle(
                  fontFamily: "RobotoMono",
                  fontWeight: FontWeight.normal,
                  fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              './assets/images/productive.png',
              height: 180, //height of image
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(height: 20),
            FutureBuilder<List<Widget>>(
              future: habits(context, category[0] as String),
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
          ])),
        )));
  }
}
