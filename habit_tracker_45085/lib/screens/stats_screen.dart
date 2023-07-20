import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

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
          'Estatísticas',
          style: TextStyle(
              fontFamily: "RobotoMono",
              fontWeight: FontWeight.normal,
              fontSize: 22),
        ),
        Image.asset(
          './assets/images/stats.png',
          height: 180, //height of image
          width: MediaQuery.of(context).size.width,
        ),
        SizedBox(
          height: 15,
        ),
        Image.asset(
          './assets/images/statsPremium.png',
          height: 390, //height of image
          width: MediaQuery.of(context).size.width,
        ),
      ]))),
    );
  }
}
