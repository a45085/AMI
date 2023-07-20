import 'package:flutter/material.dart';
import 'package:habit_tracker_45085/components/my_button.dart';
import 'package:habit_tracker_45085/theme/style.dart';

import '../firebaseConnection/authentication.dart';
import '../firebaseConnection/database.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});
  final DatabaseService database = DatabaseService();
  Future _errorMessage(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erro'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  handleSubmit(BuildContext context) async {
    try {
      String user = await Authentication().googleHandleSignIn();
      bool registerDB = await database.registerUser(user, false, true);
      if (registerDB) {
        Navigator.pushNamedAndRemoveUntil(context, 'mainScreen', (_) => false);
      } else {
        return _errorMessage(
            context, 'Não foi possível registar o utilizador.');
      }
    } catch (e) {
      return _errorMessage(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: Column(children: [
          Stack(alignment: Alignment.center, children: <Widget>[
            Image.asset('./assets/images/circle1.png'),
            Text("Habit \n Tracker",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                )),
          ]),

          //image
          Image.asset(
            './assets/images/startPage.png',
            height: 320,
            width: 320,
          ),

          const SizedBox(height: 10),
          //google button
          SizedBox(
              height: 50, //height of button
              width: 320, //width of button

              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38.0),
                      side: BorderSide(
                        color: Color(0xFFEBEAEC),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  handleSubmit(context);
                },
                child: Row(children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    './assets/images/google_logo.png',
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text('CONTINUAR COM O GOOGLE',
                      style: TextStyle(
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.normal,
                          fontSize: 14))
                ]),
              )),
          const SizedBox(height: 15),
          //alternative text
          Text("OU REGISTE COM O EMAIL",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: greylettering,
                fontFamily: "RobotoMono",
                fontWeight: FontWeight.normal,
              )),

          const SizedBox(height: 15),
          //register button
          MyButton(
              text: "REGISTAR",
              onPressed: () {
                Navigator.pushNamed(context, 'registration');
              }),
          //login
          const SizedBox(height: 15),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('JÁ POSSUI UMA CONTA? ',
                style: TextStyle(
                    fontFamily: "RobotoMono",
                    fontWeight: FontWeight.normal,
                    color: greylettering,
                    fontSize: 14)),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
              child: Text('LOG IN',
                  style: TextStyle(
                      fontFamily: "RobotoMono",
                      fontWeight: FontWeight.normal,
                      color: myTheme.primaryColor,
                      fontSize: 14)),
            ),
          ]),
        ]))));
  }
}
