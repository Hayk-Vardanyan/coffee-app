import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/home/home_widgets/brew_list.dart';
import 'package:firebase/screens/home/home_widgets/settings_form.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_widgets/brew_model.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: const SettingsForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew?>?>.value(
        value: DatabaseService().brews,
        initialData: null,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: const Text('Coffee App'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FittedBox(
                      child: Column(
                        // crossAxisAlignment : CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              AuthService().signOut();
                            },
                            icon: const Icon(
                              Icons.logout,
                            ),
                          ),
                          const Text('Logout'),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showSettingsBottomSheet(context);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: const BrewList(),
        ));
  }
}
