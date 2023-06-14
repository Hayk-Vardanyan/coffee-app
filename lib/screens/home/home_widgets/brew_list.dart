import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_model.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew?>?>(context);
    // brews?.forEach((element) {
    //   print(element?.name);
    //   print(element?.sugars);
    //   print(element?.strength);
    // });
    if (brews != null) {
      return ListView.builder(
        itemBuilder: (_, index) {
          return BrewTile(brew: brews[index]);
        },
        itemCount: brews.length,
      );
    } else {
      return const SizedBox();
    }
  }
}
