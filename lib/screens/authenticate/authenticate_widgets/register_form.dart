import 'dart:core';

import 'package:flutter/material.dart';

import '../../../ui_utils/inputDecoration.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.registerOrSignInWithEmailAndPassword,
    required this.title,
    required this.onLoadingChanged,
    required this.error,

  }) : super(key: key);

  final void Function(String) onEmailChanged;
  final void Function(String) onPasswordChanged;
  final void Function(bool) onLoadingChanged;
  final Future Function()? registerOrSignInWithEmailAndPassword;
  final String error;
  final String title;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: inputDecoration('Enter your email'),
              validator: (val) => val!.isEmpty ? 'Enter email' : null,
              onChanged: (val) => widget.onEmailChanged(val),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: inputDecoration('Enter your password'),
              validator: (val) => val!.length < 6
                  ? 'Enter password with length more or equal than 6'
                  : null,
              obscureText: true,
              onChanged: (val) => widget.onPasswordChanged(val),
            ),
            const SizedBox(height: 12.0,),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => widget.onLoadingChanged(true));
                  dynamic result =
                      await widget.registerOrSignInWithEmailAndPassword!();
                  if (result == null) {
                    print('not valid');
                    widget.onLoadingChanged(false);
                    // setState(() {
                    //   error = 'Please enter a valid email';
                    //   // widget.onLoadingChanged(false);
                    // });
                  }
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
              child: Text(widget.title),
            ),
            Text(
              widget.error,
              style: const TextStyle(color: Colors.red, fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}

