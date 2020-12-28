import 'package:flutter/material.dart';

class TextInputDecoration {

  final String labelText;
  final String errorText;

  TextInputDecoration({this.labelText = "", this.errorText});

  InputDecoration getInputDecoration() {
    return InputDecoration(
      alignLabelWithHint: true,
      labelText: labelText,
      fillColor: Colors.white,
      errorText: errorText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(),
      ),
    );
  }
}