import 'package:flashcards/injection_container.dart';
import 'package:flashcards/presentation/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: ThemeData(
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
              labelStyle: const TextStyle(color: Colors.black, fontSize: 20))),
      home: const HomePage(),
    );
  }
}
