import 'package:firebase/screens/authenticate/authenticate_widgets/register_form.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/services/database.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService authService = AuthService();

  String email = '';
  String password = '';
  bool loading = false;
  String error = '';

  void onEmailChanged(String value) => setState(() {
        email = value;
      });

  void onPasswordChanged(String value) => setState(() {
        password = value;
      });

  void onLoadingChanged(bool value) => setState(() {
    if (value == false) {
      error = 'Please enter a valid email';
    }
    loading = value;
  });


  Future registerWithEmailAndPassword() async {
    return await authService.registerWithEmailAndPassword(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: const Text('Sign up to Brew Crew'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: const Icon(
                        Icons.person,
                      ),
                    ),
                    const Text('Sign in'),
                  ],
                ),
              ),
            ]),
        body: RegisterForm(
          onEmailChanged: onEmailChanged,
          onPasswordChanged: onPasswordChanged,
          registerOrSignInWithEmailAndPassword : registerWithEmailAndPassword,
          onLoadingChanged: onLoadingChanged,
          title: 'Register',
          error: '',
        ));
  }
}
