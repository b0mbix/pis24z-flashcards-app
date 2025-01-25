import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  const MyFormField(
      {required this.name,
      this.customOnSaved,
      this.nullable = false,
      super.key});

  final String name;
  final Function? customOnSaved;
  final bool nullable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) {
        if (customOnSaved != null) {
          customOnSaved!(newValue);
        }
      },
      validator: (value) {
        if (!nullable && value == "") {
          return "Field cannot be empty";
        }
        return null;
      },
      style: const TextStyle().copyWith(color: Colors.black),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: name,
      ),
    );
  }
}
