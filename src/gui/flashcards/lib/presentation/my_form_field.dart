import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  const MyFormField(this.name, {super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                style: TextStyle().copyWith(color: Colors.black),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: name,
                ),
              );
  }
}