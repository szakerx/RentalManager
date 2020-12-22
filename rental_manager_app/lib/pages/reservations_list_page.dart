import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/widgets/side_menu.dart';

class ReservationsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReservationsListState();
  }
}

class ReservationsListState extends State<ReservationsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDrawer(),
      appBar: AppBar(title: Text("Obiekty"),),
      body: Text("Reservations"),
    );
  }
}