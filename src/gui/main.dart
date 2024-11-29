import 'package:flutter/material.dart';
import 'components/component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World App',
      home: Scaffold(
        appBar: AppBar(title: Text('Hello Main')),
        body: Center(child: SampleComponent()),
      ),
    );
  }
}
