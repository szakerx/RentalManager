import 'package:flutter/material.dart';
import 'package:rental_manager_app/widgets/calendar.dart';
import 'package:rental_manager_app/widgets/filters_menu.dart';
import 'package:rental_manager_app/widgets/side_menu.dart';

class HomePage extends StatelessWidget {

  final _key = GlobalKey<ScaffoldState>();
  Calendar calendar = Calendar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: SideMenuDrawer(),
      endDrawer: FiltersMenuDrawer(calendar),
      appBar: AppBar(
        title: Text('Strona główna'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              _key.currentState.openEndDrawer();
            },
          ),
        ],
      ),
      body: calendar
    );
  }
}