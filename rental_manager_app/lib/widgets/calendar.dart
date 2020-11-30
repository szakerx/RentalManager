import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/holidays.dart';
import 'package:rental_manager_app/widgets/calendar_reservation_items.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class Calendar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return CalendarState();
  }
}

class CalendarState extends State<Calendar> {
  CalendarController _calendarController = CalendarController();

  DateTime _selectedDay = DateTime.now();

  void _setSelectedDay() {
    setState(() {
      _selectedDay = _calendarController.selectedDay;
    });
  }

  String formatedDate(DateTime date)  {
    DateFormat format = DateFormat('dd MMMM yyyy');
    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TableCalendar(
          rowHeight: 45.0,
          calendarController: _calendarController,
          locale: 'pl_PL',
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18.0),
              weekendStyle: Theme.of(context).textTheme.bodyText1.copyWith( fontSize: 18.0)
          ),
          events: Holidays().holidaysMap,
          holidays: Holidays().holidaysMap, // Important dates
          // events: Dates when user declares he's events
          calendarStyle: CalendarStyle(
              selectedColor: CustomColors.darkGreen,
              todayColor: CustomColors.green,
              weekdayStyle: Theme.of(context).textTheme.bodyText1,
              weekendStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black54),
              outsideWeekendStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black38),
              outsideStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black26),
              holidayStyle: Theme.of(context).textTheme.bodyText1.copyWith(color:Colors.orangeAccent),
              outsideHolidayStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.orangeAccent[100]),
              markersMaxAmount: 100
          ),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            titleTextStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: CustomColors.darkGreen, fontSize: 20.0),
            formatButtonVisible: false,
          ),
          onDaySelected: (date, events, holidays) {
            print(date);
            _setSelectedDay();
          },
          builders: CalendarBuilders(
            markersBuilder: (context, date, events, holidays) {
              if (events.isNotEmpty) {
                var _color;
                if (events.length == 1)
                  _color = Colors.green[200];
                if (events.length > 1)
                  _color = Colors.orange[200];
                if (events.length > 3)
                  _color = Colors.red[200];
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
        Expanded(child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child:
                Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(90.0)),
                      color: CustomColors.lightGreen,
                    ),
                    child: Column(

                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text(formatedDate(_selectedDay),
                              style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 35.0),
                            ),
                          ),
                        ),
                        Divider(height: 1, thickness: 1, color: CustomColors.white),
                        Expanded(child: CalendarReservationItems())
                      ],
                    )
                )
              )
            ],
          )
        )
      ],
    );
  }

}