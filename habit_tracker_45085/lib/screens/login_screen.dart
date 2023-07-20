import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_45085/components/my_button.dart';
import 'package:habit_tracker_45085/components/my_text_field.dart';
import 'package:habit_tracker_45085/firebaseConnection/authentication.dart';
import 'package:habit_tracker_45085/theme/style.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future _errorMessage(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(''),
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
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    if (email.isEmpty || password.isEmpty) {
      return _errorMessage(context, 'Preencha todos os campos');
    }
    try {
      await Authentication().signInWithEmailAndPassword(email, password);
      Navigator.pushNamedAndRemoveUntil(context, 'mainScreen', (_) => false);
    } on FirebaseAuthException {
      _errorMessage(context, 'O Email ou Password estão incorretos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: myTheme.primaryColor, // <-- SEE HERE
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'startPage');
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Form(
          child: Center(
              child: SingleChildScrollView(
            child: Column(children: [
              Text('Bem vindo de volta!',
                  style: TextStyle(
                      fontFamily: "RobotoMono",
                      fontWeight: FontWeight.normal,
                      fontSize: 24)),
              SizedBox(height: 20),
              Image.asset(
                './assets/images/login_page.png',
                width: 330,
                height: 330,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: _emailController,
                hintText: 'Endereço de email',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // password textfield
              MyTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira uma password';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              MyButton(
                text: "LOG IN",
                onPressed: () {
                  handleSubmit(context);
                },
              ),
              SizedBox(height: 20),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('NÃO POSSUI UMA CONTA? ',
                    style: TextStyle(
                        fontFamily: "RobotoMono",
                        fontWeight: FontWeight.normal,
                        color: greylettering,
                        fontSize: 14)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'registration');
                  },
                  child: Text('REGISTO',
                      style: TextStyle(
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.normal,
                          color: myTheme.primaryColor,
                          fontSize: 14)),
                ),
              ]),
            ]),
          )),
        )));
  }
}
