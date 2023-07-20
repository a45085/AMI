import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_45085/screens/friends_screen.dart';
import 'package:habit_tracker_45085/screens/home_screen.dart';
import 'package:habit_tracker_45085/screens/profile_sceen.dart';
import 'package:habit_tracker_45085/screens/stats_screen.dart';

import '../firebaseConnection/authentication.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? mtoken = " ";

  final String? user = Authentication().getCurrentUser();
  DatabaseService databaseService = DatabaseService();
  List pages = [
    HomeScreen(),
    StatsScreen(),
    FriendsScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) => {
          setState(() {
            mtoken = token;
            print("My token is $mtoken");
          }),
          saveToken(user!, token!)
        });
  }

  void saveToken(String uid, String token) async {
    await databaseService.updateToken(user!, token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: (currentIndex == 0)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'categories',
                );
              },
              tooltip: 'Add',
              elevation: 5.0,
              backgroundColor: myTheme.primaryColor,
              child: Icon(Icons.add),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: myTheme.primaryColor,
        unselectedItemColor: bottomNavIconsColor,
        type: BottomNavigationBarType.fixed, // Set type to fixed
        currentIndex: (currentIndex < 4) ? currentIndex : 0,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart_rounded),
            label: 'Charts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
