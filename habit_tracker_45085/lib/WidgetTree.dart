import 'package:flutter/material.dart';
import 'package:habit_tracker_45085/firebaseConnection/authentication.dart';
import 'package:habit_tracker_45085/screens/main_Screen.dart';
import 'package:habit_tracker_45085/screens/start_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTree();
}

class _WidgetTree extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Authentication().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainScreen();
          } else {
            return StartScreen();
          }
        });
  }
}
