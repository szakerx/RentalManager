

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

  @override
  void initState() {
    super.initState();
    reservations = Remote.fetchHoliday(2020, 12, 25);
    print(widget.holidays);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: reservations,
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Święta",
                    textAlign: TextAlign.left, style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),
                  widget.holidays.length > 0 ?
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.holidays.length,
                      itemBuilder: (_, index){
                        return Container(
                          padding: EdgeInsets.only(left: 20.0, top: 15.0),
                          child: Text(widget.holidays[index].name),
                        );
                      },
                    ),
                    flex: 1,
                  ) : ListTile(title: Text("Brak świąt w dniu dzisiejszym")),
                  Text("Rezerwacje",
                    textAlign: TextAlign.left, style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),
                  snapshot.data.length > 0 ?
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index){
                        return ListTile(title: Text(snapshot.data[index].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("18:00", textAlign: TextAlign.left,),
                              Text("Jan Kowalski", textAlign: TextAlign.left,)
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                        );
                      },
                    ),
                    flex: 2,
                  ) : ListTile(title: Text("Brak rezerwacji"),),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          return CircularProgressIndicator(backgroundColor: CustomColors.green,);
        });
  }

}