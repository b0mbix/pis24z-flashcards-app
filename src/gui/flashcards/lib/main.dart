import 'package:flashcards/core/theme.dart';
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
      theme: theme,
      home: const HomePage(),
    );
  }
}
