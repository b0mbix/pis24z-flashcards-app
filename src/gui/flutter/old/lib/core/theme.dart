import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        labelStyle: const TextStyle(color: Colors.black, fontSize: 20)));
