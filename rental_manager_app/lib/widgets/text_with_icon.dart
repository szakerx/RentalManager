import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWithIcon extends StatelessWidget {
  String text;
  IconData icon;
  Color color;

  TextWithIcon({this.text, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color,),
        Padding(padding: EdgeInsets.all(20.0)),
        Text(text,
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20.0, color: color))
      ],
    );
  }

}