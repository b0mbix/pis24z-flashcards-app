import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  const MyFormField(
      {required this.name, this.customOnSaved, super.key});

  final String name;
  final Function? customOnSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        if (customOnSaved != null) {
          customOnSaved!(newValue);
        }
      },
      style: const TextStyle().copyWith(color: Colors.black),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: name,
      ),
    );
  }
}
