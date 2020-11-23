import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomColors {
  static Map<int, Color> _colorCodes = {
    50: Color.fromRGBO(182, 222, 198, .1),
    100: Color.fromRGBO(182, 222, 198, .2),
    200: Color.fromRGBO(182, 222, 198, .3),
    300: Color.fromRGBO(182, 222, 198, .4),
    400: Color.fromRGBO(182, 222, 198, .5),
    500: Color.fromRGBO(182, 222, 198, .6),
    600: Color.fromRGBO(182, 222, 198, .7),
    700: Color.fromRGBO(182, 222, 198, .8),
    800: Color.fromRGBO(182, 222, 198, .9),
    900: Color.fromRGBO(182, 222, 198, 1),
  };

  static MaterialColor color = new MaterialColor(0xFF86AC95, _colorCodes);

  static const white = Color(0xffF9FEFF);
  static const lightWhite = Color(0xffD9CCC1);
  static const lightBlue = Color(0xffA2BCBD);
  static const lightGreen = Color(0xff86AC95);
  static const darkBlue = Color(0xff00665E);
  static const darkBlack = Color(0xff000700);

  static const lightOrange = Color(0xffF2B680);
  static const orange = Color(0xffF2856D);
  static const darkOrange = Color(0xffA66A6A);
  static const darkestOrange = Color(0xff735C68);


  CustomColors._singleton();
  static final CustomColors _instance = CustomColors._singleton();

  factory CustomColors() {
    return _instance;
  }
}