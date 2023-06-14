import 'package:firebase/screens/authenticate/authenticate_widgets/loading_widget.dart';
import 'package:firebase/screens/authenticate/authenticate_widgets/register_form.dart';
import 'package:firebase/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService authService = AuthService();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

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

  Future signInWithEmailAndPassword() async {
    print('call');
    return await authService.signInWithEmailAndPassword(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return !loading ? Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Sign in to Brew Crew'),
          actions: <Widget>[
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
                  const Text('register'),
                ],
              ),
            ),
          ],
        ),
        body: RegisterForm(
          onEmailChanged: onEmailChanged,
          onPasswordChanged: onPasswordChanged,
          registerOrSignInWithEmailAndPassword: signInWithEmailAndPassword,
          title: 'Sign in',
          onLoadingChanged: onLoadingChanged,
          error: error,
        )
    ) : const LoadingWidget();
  }
}
