import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';
import 'package:rental_manager_app/widgets/menu_items.dart';
import 'package:rental_manager_app/widgets/text_with_icon.dart';

class SideMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: MenuItems(),
      )
    );
  }
  
}