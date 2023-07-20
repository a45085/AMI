import 'package:flutter/material.dart';

import '../components/button_with_image_component.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

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
          child: Center(
              child: Column(children: [
        Text(
          'Amigos',
          style: TextStyle(
              fontFamily: "RobotoMono",
              fontWeight: FontWeight.normal,
              fontSize: 22),
        ),
        SizedBox(height: 15),
        Image.asset(
          './assets/images/amigos.png',
          height: 180, //height of image
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(height: 10),
        ButtonWithImageComponent(
          text: "Adicionar amigos",
          image: './assets/images/addFriends.png',
          onPressed: () {},
        ),
        ButtonWithImageComponent(
          text: "Partilhar hábito",
          image: './assets/images/partilharHabito.png',
          onPressed: () {},
        ),
        ButtonWithImageComponent(
          text: "Hábitos partilhados",
          image: './assets/images/sharedHabits.png',
          onPressed: () {},
        ),
      ]))),
    );
  }
}
