import 'package:flutter/material.dart';

InputDecoration inputDecoration(String hintText) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0),
    ),
    hintText: hintText,
  );
}