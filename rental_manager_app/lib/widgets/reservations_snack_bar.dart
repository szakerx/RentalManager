import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/reservation.dart';

import 'custom_colors.dart';

class ReservationsSnackBar extends StatelessWidget {

  String start;
  String end;

  ReservationsSnackBar(this.start, this.end);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
                color: CustomColors.lightGreen,
              ),
              height: 100.0,
              child: Center(
                child:  Text("$start - $end",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 24.0),
                ),
              )
            ),
            Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: availabilityList(context, List(), List()),
                ),

            ),
          ],
        ),
    );
  }
  
  List<Widget> availabilityList(BuildContext context, List<Reservation> available, List<Reservation> partiallyAvailable) {
    List<Widget> availableTiles = List();
    List<Widget> partiallyAvailableTiles = List();
    available.forEach((element) {
      // ListTile(title: element.rentalObject,)
// TODO: finish this - fill with reservations
    });
    return [
      Container(
        padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Center(
                  child: Text("Dostępne",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)
                  )
              ),
              decoration: BoxDecoration(
                  color: CustomColors.darkGreen,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30.0))
              ),
            )
          ],
        ),
      ),


      Container(
        padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Center(
                  child: Text("Częściowo dostępne",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)
                  )
              ),
              decoration: BoxDecoration(
                  color: CustomColors.orange,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30.0))
              ),
            )
          ],
        ),
      ),
    ];
  }
}