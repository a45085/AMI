import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_45085/WidgetTree.dart';
import 'package:habit_tracker_45085/screens/categories_screen.dart';
import 'package:habit_tracker_45085/screens/category_screen.dart';
import 'package:habit_tracker_45085/screens/friends_screen.dart';
import 'package:habit_tracker_45085/screens/habit_form_screen.dart';
import 'package:habit_tracker_45085/screens/list_habits_screen.dart';
import 'package:habit_tracker_45085/screens/login_screen.dart';
import 'package:habit_tracker_45085/screens/main_Screen.dart';
import 'package:habit_tracker_45085/screens/register_screen.dart';
import 'package:habit_tracker_45085/screens/start_screen.dart';
import 'package:habit_tracker_45085/theme/style.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  /*
  String categorias =
      await rootBundle.loadString('assets/databaseDocuments/categorias.json');
  String users =
      await rootBundle.loadString('assets/databaseDocuments/users.json');
  String habits =
      await rootBundle.loadString('assets/databaseDocuments/habits.json');

  for (var cat in jsonDecode(categorias) as List) {
    await FirebaseFirestore.instance.collection('categories').add(cat);
  }
  for (var user in jsonDecode(users) as List) {
    await FirebaseFirestore.instance.collection('users').add(user);
  }
  for (var habit in jsonDecode(habits) as List) {
    await FirebaseFirestore.instance.collection('habits').add(habit);
  } */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: WidgetTree(),
      routes: {
        'startPage': (context) => StartScreen(),
        'login': (context) => LoginScreen(),
        'registration': (context) => RegisterScreen(),
        'listHabits': (context) => ListHabitsScreen(),
        'habitForm': (context) => HabitFormScreen(),
        'friends': (context) => FriendsScreen(),
        'category': (context) => CategoryScreen(),
        'categories': (context) => CategoriesScreen(),
        'mainScreen': (context) => MainScreen(),
      },
    );
  }
}
