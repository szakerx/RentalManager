import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/holidays.dart';
import 'package:rental_manager_app/model/holiday.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/model/rental_object.dart';
import 'package:rental_manager_app/model/reservation.dart';
import 'package:rental_manager_app/pages/reservations_page.dart';
import 'package:rental_manager_app/widgets/calendar_reservation_items.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';
import 'package:rental_manager_app/widgets/filters_state.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  final CalendarState calendarState = CalendarState();


  void setSelectedDay(DateTime data) {
    calendarState.setSelectedDay(data);
  }

  void setFilteredReservations(RentalObject rentalObject) {
    calendarState.setFilteredReservations(rentalObject);
  }

  void cancelFilteringReservations() {
    calendarState.cancelFilteringReservations();
  }

  List<Reservation> getReservationsList(DateTime start, DateTime end) {
    return calendarState.getReservationsList(start, end);
  }

  @override
  State<StatefulWidget> createState() {
    return calendarState;
  }
}

class CalendarState extends State<Calendar> {
  CalendarController _calendarController = CalendarController();
  DateTime _selectedDay;
  Future<Map<DateTime, List<Holiday>>> _holidays;
  Future<List<Reservation>> _reservations;
  Future<List<RentalObject>> _rentalObjects;
  Map<DateTime, List<Reservation>> _mappedReservations;
  Map<DateTime, List<Reservation>> _mappedReservationsBackup;

  @override
  void initState() {
    super.initState();
    DateTime now = new DateTime.now();
    _selectedDay = DateTime(now.year, now.month, now.day);
    _holidays = Holidays().getHolidays();
    _rentalObjects = Remote.getRentalObjects();
    _reservations = Remote.getReservations().then((value) {
        _mappedReservations = mapReservations(value);
        return value;
      });
  }

  Map<DateTime, List<Reservation>> mapReservations(
      List<Reservation> reservations) {
    Map<DateTime, List<Reservation>> result = Map();
    reservations.forEach((element) {
      var start = DateTime.parse(element.startDate);
      var end = DateTime.parse(element.endDate);
      var days = end.difference(start).inDays;
      for (var i = 0; i <= days; i++) {
        var date = start.add(Duration(days: i));
        if (result[date] == null) {
          result[date] = List();
        }
        result[date].add(element);
      }
    });

    return result;
  }

  void setFilteredReservations(RentalObject rentalObject) {
    _mappedReservationsBackup = Map.of(_mappedReservations);
    setState(() {
      _mappedReservations.forEach((d, r) {
        _mappedReservations[d] = r
            .where((element) => element.rentalObject.id == rentalObject.id)
            .toList();
      });
    });
  }

  void cancelFilteringReservations() {
    setState(() {
      FiltersState.filtering = false;
      _mappedReservations = _mappedReservationsBackup;
    });
  }

  void updateReservations() {
    setState(() {
      _reservations = Remote.getReservations().then((value) {
        _mappedReservations = mapReservations(value);
        return value;
      });
    });
  }

  void setSelectedDay(DateTime data) {
    DateTime formatted = DateTime(data.year, data.month, data.day);
    setState(() {
      _calendarController.setSelectedDay(formatted);
      _selectedDay = formatted;
    });
  }

  void _setSelectedDay() {
    DateTime formatted = DateTime(
        _calendarController.selectedDay.year,
        _calendarController.selectedDay.month,
        _calendarController.selectedDay.day);
    setState(() {
      _selectedDay = formatted;
    });
  }

  List<Reservation> getReservationsList(DateTime start, DateTime end) {
    Map<DateTime, List<Reservation>> map;
    if (FiltersState.filtering) {
      map = Map.of(_mappedReservationsBackup);
    } else {
      map = Map.of(_mappedReservations);
    }

    List<Reservation> result = List();
    map.values.forEach((element) {
      result.addAll(element);
    });
    return result;
  }

  String formattedDate(DateTime date) {
    DateFormat format = DateFormat('dd MMMM yyyy');
    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_holidays, _reservations, _rentalObjects]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TableCalendar(
                  rowHeight: 45.0,
                  calendarController: _calendarController,
                  locale: 'pl_PL',
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 18.0),
                      weekendStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 18.0)),
                  holidays: snapshot.data[0],
                  events: _mappedReservations,
                  calendarStyle: CalendarStyle(
                      selectedColor: CustomColors.darkGreen,
                      todayColor: CustomColors.green,
                      weekdayStyle: Theme.of(context).textTheme.bodyText1,
                      weekendStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black54),
                      outsideWeekendStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black38),
                      outsideStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.black26),
                      holidayStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.orangeAccent),
                      outsideHolidayStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.orangeAccent[100]),
                      markersMaxAmount: 100),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    titleTextStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(
                            color: CustomColors.darkGreen, fontSize: 20.0),
                    formatButtonVisible: false,
                  ),
                  onDaySelected: (date, events, holidays) {
                    _setSelectedDay();
                  },
                  onVisibleDaysChanged:
                      (DateTime first, DateTime last, CalendarFormat format) {
                    setState(() {});
                  },
                  builders: CalendarBuilders(
                    markersBuilder: (context, date, events, holidays) {
                      if (events.isNotEmpty) {
                        var _color;
                        if (events.length < snapshot.data[2].length / 2) _color = Colors.green[200];
                        else if (events.length < snapshot.data[2].length) _color = Colors.orange[200];
                        else if (events.length >= snapshot.data[2].length) _color = Colors.red[200];
                        return [
                          Align(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _color,
                              ),
                              width: 8.0,
                              height: 8.0,
                            ),
                            alignment: Alignment.bottomCenter,
                          )
                        ];
                      }
                      return <Widget>[];
                    },
                  ),
                ),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(90.0)),
                              color: CustomColors.lightGreen,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          formattedDate(_selectedDay),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(fontSize: 30.0),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) =>
                                                  ReservationsPage(
                                                    calendar: this,
                                                      isInEditMode: true,
                                                      reservation: Reservation(
                                                          startDate:
                                                              DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)
                                                                  .toString(),
                                                          endDate: DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day)
                                                              .toString()))));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: CustomColors.white),
                                Expanded(
                                    child: Stack(
                                  children: [
                                    CalendarReservationItems(
                                        _mappedReservations[_selectedDay] ==
                                                null
                                            ? List()
                                            : _mappedReservations[_selectedDay],
                                        snapshot.data[0][_selectedDay] == null
                                            ? List()
                                            : snapshot.data[0][_selectedDay]),
                                    FiltersState.filtering
                                        ? Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  cancelFilteringReservations();
                                                },
                                                child:
                                                    Text("Zakończ filtrowanie"),
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                )),
                              ],
                            )))
                  ],
                )),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
