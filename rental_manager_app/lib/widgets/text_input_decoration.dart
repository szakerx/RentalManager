import 'package:flutter/material.dart';

class TextInputDecoration {

  final String labelText;

  TextInputDecoration({this.labelText = ""});

  InputDecoration getInputDecoration() {
    return InputDecoration(
      labelText: labelText,
      fillColor: Colors.white,
      border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
        borderSide: new BorderSide(),
      ),
    );
  }
}