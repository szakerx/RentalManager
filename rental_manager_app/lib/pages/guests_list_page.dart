import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/widgets/side_menu.dart';

class GuestsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuestsListState();
  }
}

class GuestsListState extends State<GuestsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDrawer(),
      appBar: AppBar(title: Text("Obiekty"),),
      body: Text("Guests"),
    );
  }
}