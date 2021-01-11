import 'package:rental_manager_app/model/holiday.dart';

class Holidays {

  Map<DateTime, List<Holiday>> _map = {
    DateTime.parse("2020-11-01T00:00:00.000"): [Holiday(name: "Wszystkich Świętych")],
    DateTime.parse("2020-11-11T00:00:00.000"): [Holiday(name: "Święto Niepodległości")],
    DateTime.parse("2020-12-24T00:00:00.000"): [Holiday(name: "Wigilia")],
    DateTime.parse("2020-12-25T00:00:00.000"): [Holiday(name: "Pierwszy Dzień Bożego Narodzenia")],
    DateTime.parse("2020-12-24T00:00:00.000"): [Holiday(name: "Drugi Dzień Bożego Narodzenia")],
    DateTime.parse("2020-12-31T00:00:00.000"): [Holiday(name: "Sylwester")],
    DateTime.parse("2021-01-01T00:00:00.000"): [Holiday(name: "Nowy Rok")],
    DateTime.parse("2021-01-06T00:00:00.000"): [Holiday(name: "Trzech Króli")],
    DateTime.parse("2021-02-14T00:00:00.000"): [Holiday(name: "Walentynki")],
    DateTime.parse("2021-04-02T00:00:00.000"): [Holiday(name: "Wielki Piątek")],
    DateTime.parse("2021-04-03T00:00:00.000"): [Holiday(name: "Wielka Sobota")],
    DateTime.parse("2021-04-04T00:00:00.000"): [Holiday(name: "Wielkanoc")],
    DateTime.parse("2021-04-05T00:00:00.000"): [Holiday(name: "Lany Poniedziałek")],
    DateTime.parse("2021-05-01T00:00:00.000"): [Holiday(name: "Święto Pracy")],
    DateTime.parse("2021-05-02T00:00:00.000"): [Holiday(name: "Święto Flagi")],
    DateTime.parse("2021-05-03T00:00:00.000"): [Holiday(name: "Konstytucji 3-go Maja")],
    DateTime.parse("2021-05-26T00:00:00.000"): [Holiday(name: "Dzień Matki")],
  };

  Future<Map<DateTime, List<Holiday>>> getHolidays() async {
    return _map;
  }
}