import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../firebaseConnection/authentication.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class HabitComponent extends StatefulWidget {
  const HabitComponent({
    Key? key,
    required this.text,
    required this.habitId,
    required this.image,
    required this.onPressed,
    required this.isSlidable,
    required this.isInHomeScreen,
    required this.onDelete,
  }) : super(key: key);

  final String text;
  final String image;
  final String habitId;
  final VoidCallback onPressed;
  final bool isSlidable;
  final bool isInHomeScreen;
  final VoidCallback onDelete;

  @override
  _HabitComponentState createState() => _HabitComponentState();
}

class _HabitComponentState extends State<HabitComponent> {
  bool isChecked = false;
  final String? user = Authentication().getCurrentUser();
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: SizedBox(
          height: 90,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: habitButton,
            elevation: 5,
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Slidable(
              enabled: widget.isSlidable,
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: widget.isInHomeScreen
                    ? [
                        SlidableAction(
                          label: isChecked
                              ? 'Hábito efetuado'
                              : 'Marcar como efetuado',
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          backgroundColor: Colors.green,
                          icon: isChecked ? Icons.check_circle : Icons.check,
                          onPressed: (context) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                        ),
                      ]
                    : [
                        SlidableAction(
                          label: 'Editar',
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          backgroundColor: Colors.blue,
                          icon: Icons.edit,
                          onPressed: (context) {
                            print('Edit tapped');
                          },
                        ),
                        SlidableAction(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          label: 'Apagar',
                          backgroundColor: Colors.red,
                          icon: Icons.close,
                          onPressed: (context) async {
                            bool removed = await databaseService
                                .removeHabitFromUser(user!, widget.habitId);
                            if (removed) {
                              widget.onDelete(); // Call the onDelete callback
                            }
                          },
                        ),
                      ],
              ),
              child: Center(
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(
                      30, 0, 30, 0), // Adjust the padding as desired
                  leading: Image.asset(
                    './assets/images/icon_smartphone.png',
                    height: 40,
                    width: 40,
                  ), // Add your image here
                  title: Text(
                    widget.text,
                    style: TextStyle(
                      fontFamily: "RobotoMono",
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      decoration: isChecked ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
