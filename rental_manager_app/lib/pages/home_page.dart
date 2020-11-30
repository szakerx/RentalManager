import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/widgets/calendar.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';
import 'package:rental_manager_app/widgets/side_menu.dart';

class HomePage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDrawer(),
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Filtrowanie',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              //TODO filtrowanie
              print("Filtruj");
            },
          ),
        ],
      ),
      body: Calendar()
    );
  }
}