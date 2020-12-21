

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/holiday.dart';
import 'package:rental_manager_app/model/remote.dart';

import 'custom_colors.dart';

class CalendarReservationItems extends StatefulWidget {
  List<Holiday> holidays;

  CalendarReservationItems(this.holidays);

  @override
  State<StatefulWidget> createState() {
    return CalendarReservationItemsState();
  }
}

class CalendarReservationItemsState extends State<CalendarReservationItems> {


  Future<List<Holiday>> reservations;
  List<Holiday> holidays;

  @override
  void initState() {
    super.initState();
    reservations = Remote.fetchHoliday(2020, 12, 25);
    print(widget.holidays);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Holiday>>(
        future: reservations,
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return Column(
              children: [
                holidays != null ?
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.holidays.length,
                    itemBuilder: (_, index){
                      return ListTile(title: Text(widget.holidays[index].name),);
                    },
                  ),
                  flex: 2,
                ) : Text("Brak świąt w dniu dzisiejszym"),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index){
                      return ListTile(title: Text(snapshot.data[index].name),);
                    },
                  ),
                  flex: 1,//This widget get 1/3 of screen size
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return CircularProgressIndicator(backgroundColor: CustomColors.green,);
        });
  }

}