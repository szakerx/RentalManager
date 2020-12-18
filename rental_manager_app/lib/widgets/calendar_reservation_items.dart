

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/remote.dart';

import 'custom_colors.dart';

class CalendarReservationItems extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CalendarReservationItemsState();
  }
}

class CalendarReservationItemsState extends State<CalendarReservationItems> {

  Future<Album> reservations;

  @override
  void initState() {
    super.initState();
    reservations = Remote.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
        future: reservations,
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Text(snapshot.data.title)
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return CircularProgressIndicator(backgroundColor: CustomColors.green,);
        });
  }
}