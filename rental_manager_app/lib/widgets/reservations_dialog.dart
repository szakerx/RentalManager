import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_manager_app/model/rental_object.dart';
import 'package:rental_manager_app/model/reservation.dart';

import 'custom_colors.dart';

class ReservationsDialog extends StatelessWidget {

  String userStartDateString;
  String userEndDateString;

  List<Reservation> reservations;
  List<RentalObject> rentalObjects;

  ReservationsDialog(this.userStartDateString, this.userEndDateString, this.reservations, this.rentalObjects);

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
                child:  Text("$userStartDateString - $userEndDateString",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 24.0),
                ),
              )
            ),
            Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: availabilityList(context),
                ),

            ),
          ],
        ),
    );
  }

  List<Widget> availabilityList(BuildContext context) {
    List<Widget> result = List();

    List<RentalObject> available = getAvailableRentalObjects();
    List<RentalObject> partiallyAvailable = getPartiallyAvailableRentalObjects();

    Widget availableHeader = Container(
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
    );
    Widget partiallyAvailableHeader = Container(
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
    );

    List<Widget> availableTiles = List();
    List<Widget> partiallyAvailableTiles = List();
    available.forEach((element) {
      availableTiles.add(ListTile(title: Text(element.name),));
    // TODO: finish this - fill with reservations
    });

    partiallyAvailable.forEach((element) {
      partiallyAvailableTiles.add(ListTile(title: Text(element.name),));
      // TODO: finish this - fill with reservations
    });

    result.add(availableHeader);
    result.addAll(availableTiles);
    result.add(partiallyAvailableHeader);
    result.addAll(partiallyAvailableTiles);

    return result;
  }

  List<RentalObject> getAvailableRentalObjects() {
    DateTime userStartDate = DateFormat("dd.MM.yyyy").parse(userStartDateString);
    DateTime userEndDate = DateFormat("dd.MM.yyyy").parse(userEndDateString);

    List<RentalObject> result = List.of(rentalObjects);

    print(result);

    reservations.forEach((reservation) {
      DateTime start = DateTime.parse(reservation.startDate);
      DateTime end = DateTime.parse(reservation.endDate);

      if (start.isBefore(userEndDate) && end.isAfter(userStartDate)) {
        result.removeWhere((object) => object.id == reservation.rentalObject.id);
      }
    });
    print(result);
    return result;
  }

  List<RentalObject> getPartiallyAvailableRentalObjects() {
    DateTime userStartDate = DateFormat("dd.MM.yyyy").parse(userStartDateString);
    DateTime userEndDate = DateFormat("dd.MM.yyyy").parse(userEndDateString);

    List<RentalObject> result = List();

    reservations.forEach((reservation) {
      DateTime start = DateTime.parse(reservation.startDate);
      DateTime end = DateTime.parse(reservation.endDate);

      if (!(end.isBefore(userStartDate.add(Duration(days: 1)))  || start.isAfter(userEndDate.subtract(Duration(days: 1)))))
      {
        result.add(reservation.rentalObject);
      }
    });
    return result.toSet().toList();
  }
}