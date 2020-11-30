import 'package:flutter/cupertino.dart';
import 'package:rental_manager_app/model/holidays.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      locale: 'pl_PL',
      holidays: Holidays().holidaysMap,
      calendarStyle: CalendarStyle(

      ),
    );
  }
}