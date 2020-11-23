import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';
import 'pages/landing_page.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Intl.defaultLocale = 'pl_PL';
  await initializeDateFormatting();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CustomColors.color,
        primaryColor: CustomColors.lightGreen,
        primaryColorLight: CustomColors.lightBlue,
        primaryColorDark: CustomColors.darkBlue,
        accentColor: CustomColors.lightOrange,
        canvasColor: CustomColors.white,
        shadowColor: CustomColors.darkBlue,
        hintColor: CustomColors.darkBlue,
        errorColor: CustomColors.darkOrange,
        fontFamily: GoogleFonts.raleway().fontFamily,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.raleway(),
          headline1: GoogleFonts.pacifico(
            fontSize: 40.0,
            color: CustomColors.lightGreen,
          ),
        )
      ),
      home: LandingPage(),
    );
  }
}