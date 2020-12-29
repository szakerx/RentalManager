import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/holiday.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/model/reservation.dart';
import 'package:rental_manager_app/pages/reservations_page.dart';
import 'custom_colors.dart';

class CalendarReservationItems extends StatefulWidget {
  List<Reservation> reservations;
  List<Holiday> holidays;

  CalendarReservationItems(this.reservations, this.holidays);

  @override
  State<StatefulWidget> createState() {
    if (reservations == null) {
      reservations = List();
    }
    if (holidays == null) {
      holidays = List();
    }
    return CalendarReservationItemsState();
  }
}

class CalendarReservationItemsState extends State<CalendarReservationItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Święta",
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.bold),
          ),
          widget.holidays.length > 0
              ? Expanded(
                  child: ListView.builder(
                    itemCount: widget.holidays.length,
                    itemBuilder: (_, index) {
                      return Container(
                        padding: EdgeInsets.only(left: 20.0, top: 15.0),
                        child: Text(widget.holidays[index].name),
                      );
                    },
                  ),
                  flex: 1,
                )
              : ListTile(title: Text("Brak świąt w dniu dzisiejszym")),
          Text(
            "Rezerwacje",
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.bold),
          ),
          widget.reservations.length > 0
              ? Expanded(
                  child: ListView.builder(
                    itemCount: widget.reservations.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReservationsPage(reservation: widget.reservations[index])));
                        },
                        title:
                            Text(widget.reservations[index].rentalObject.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getFormattedDateFromString(widget.reservations[index].startDate)} - ${getFormattedDateFromString(widget.reservations[index].endDate)}",
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "${widget.reservations[index].person.name} ${widget.reservations[index].person.surname}",
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      );
                    },
                  ),
                  flex: 2,
                )
              : ListTile(
                  title: Text("Brak rezerwacji"),
                ),
        ],
      ),
    );
  }

  String getFormattedDateFromString(String date) {
    DateTime d = DateTime.parse(date);
    return "${d.day}.${d.month}.${d.year}";
  }
}
