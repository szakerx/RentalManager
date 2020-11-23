import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';

class SideMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: CustomColors.darkOrange,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    Text('Witaj',
                      style: Theme.of(context).textTheme.headline1.copyWith(color: CustomColors.darkBlack),
                    ),
                    Text(FirebaseAuth.instance.currentUser.email,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: CustomColors.lightOrange,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      )
    );
  }
  
}