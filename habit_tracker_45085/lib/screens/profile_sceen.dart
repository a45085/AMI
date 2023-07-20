import 'package:flutter/material.dart';
import 'package:habit_tracker_45085/firebaseConnection/authentication.dart';

import '../components/about_component.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseService databaseService = DatabaseService();
  String image = "";

  Future<void> signOut() async {
    await Authentication().signOut();
  }

  Future<String> getDeveloperImage() async {
    return await databaseService.getDeveloperImage();
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AboutComponent(
          title: 'Sobre o Habit Tracker',
          descriptions:
              'O Habit Tracker é uma aplicação desenvolvida por Ana Ferreira, aluna número 45085, como parte do projeto da disciplina de Aplicações Móveis Interativas.\n \nEsta aplicação foi criada com o objetivo de ajudar os utilizadores a acompanhar e registrar seus hábitos diários. \n \nCom uma interface intuitiva e fácil de usar, o Habit Tracker oferece recursos para adicionar, visualizar e gerenciar hábitos, bem como receber notificações para incentivá-los a manter suas práticas diárias.',
          img: Image.network(image), // Pass the image URL here
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _updateImage();
  }

  Future<void> _updateImage() async {
    String imageUrl = await getDeveloperImage();
    setState(() {
      image = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
            child: Column(children: [
          Text(
            'Conta',
            style: TextStyle(
                fontFamily: "RobotoMono",
                fontWeight: FontWeight.normal,
                fontSize: 22),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            './assets/images/profile.png',
            height: 180, //height of image
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    'Notificações',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "RobotoMono",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Spacer(),
                  Switch(
                      // This bool value toggles the switch.
                      value: true,
                      activeColor: myTheme.primaryColor,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                      }),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    'Língua',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "RobotoMono",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Spacer(),
                  DropdownButton<String>(
                    iconEnabledColor: myTheme.primaryColor,
                    value:
                        'Português', // Replace with your actual selected language value
                    onChanged: (String? newValue) {
                      // Implement the logic for language selection here
                    },
                    items: <String>[
                      'Português',
                      'Inglês',
                    ] // Replace with your language options
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    'Sobre a App',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "RobotoMono",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_rounded),
                    color: myTheme.primaryColor,
                    onPressed: () {
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
              height: 55, //height of button
              width: 355,
              //width of button
              child: TextButton(
                  style: endSessionButtonStyle,
                  onPressed: () {
                    signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'startPage', (_) => false);
                  },
                  child: Text("Terminar sessão",
                      style: TextStyle(
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.normal,
                          fontSize: 18)))),
        ])),
      )),
    );
  }
}
