import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../firebaseConnection/authentication.dart';
import '../firebaseConnection/database.dart';
import '../theme/style.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final DatabaseService database = DatabaseService();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

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
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      return;
    }
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    final confirmPassword = _passwordConfirmController.value.text;

    if (password.length < 6) {
      return _errorMessage(
          context, 'Password tem que conter um mínimo de 6 caracteres.');
    }
    if (password != confirmPassword) {
      // Passwords don't match
      return _errorMessage(context, 'As passwords inseridas são diferentes.');
    }
    try {
      String user =
          await Authentication().registerWithEmailAndPassword(email, password);
      bool registerDB = await database.registerUser(user, false, false);
      if (registerDB) {
        Navigator.pushNamed(context, 'login');
      } else {
        Authentication().deleteUser();
        return _errorMessage(
            context, 'Não foi possível registar o utilizador.');
      }
    } on FirebaseAuthException {
      return _errorMessage(context, 'Não foi possível registar o utilizador.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Form(
          key: _formKey,
          child: Center(
              child: SingleChildScrollView(
            child: Column(children: [
              Text('Crie a sua conta',
                  style: TextStyle(
                      fontFamily: "RobotoMono",
                      fontWeight: FontWeight.normal,
                      fontSize: 24)),
              const SizedBox(height: 10),
              Image.asset(
                './assets/images/register_page.png',
                width: 310,
                height: 310,
              ),
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

              const SizedBox(height: 15),

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

              const SizedBox(height: 15),

              // password textfield
              MyTextField(
                controller: _passwordConfirmController,
                hintText: 'Confirmar Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirme a password';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              MyButton(
                text: "COMEÇAR",
                onPressed: () {
                  handleSubmit(context);
                },
              ),
            ]),
          )),
        )));
  }
}
