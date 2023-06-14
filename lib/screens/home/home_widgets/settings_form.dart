import 'package:firebase/models/user_data.dart';
import 'package:firebase/screens/authenticate/authenticate_widgets/loading_widget.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase/ui_utils/inputDecoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String? currentName;
  String? currentSugars;
  int? currentStrength;

  List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final User user = snapshot.data!;
          return StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final UserData userData = snapshot.data!;

                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Update your brew settings.',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: inputDecoration('Enter your name'),
                        validator: (val) => val!.isEmpty ? 'Enter email' : null,
                        onChanged: (value) => currentName = value,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      DropdownButtonFormField<String>(
                          value: userData.sugars,
                          decoration: inputDecoration(''),
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              value: sugar,
                              child: Text("$sugar sugars"),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              currentSugars = val ?? userData.sugars),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Slider(
                        value:
                            (currentStrength ?? userData.strength).toDouble(),
                        min: 100.0,
                        max: 900.0,
                        divisions: 8,
                        activeColor:
                            Colors.brown[currentStrength ?? userData.strength],
                        inactiveColor: Colors
                            .brown[(currentStrength ?? userData.strength)],
                        onChanged: (value) =>
                            setState(() => currentStrength = value.round()),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: user.uid).updateUser(
                                currentSugars ?? userData.sugars,
                                currentName ?? userData.name,
                                currentStrength ?? userData.strength);
                            Navigator.pop(context);
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.brown.shade400),
                        child: const Text('Update'),
                      ),
                    ],
                  ),
                );
              } else {
                return const LoadingWidget();
              }
            },
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
