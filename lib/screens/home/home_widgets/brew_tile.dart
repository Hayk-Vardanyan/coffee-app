import 'package:firebase/screens/home/home_widgets/brew_model.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({Key? key, required this.brew}) : super(key: key);

  final Brew? brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            // backgroundColor: brew!.strength < 5 ? Colors.brown[50] : Colors.brown[700]
            backgroundColor: Colors.brown[brew!.strength],
          ),
          title: Text(brew!.name),
          subtitle: Text("Takes ${brew!.sugars} sugars"),
        ),
      ),
    );
  }
}
