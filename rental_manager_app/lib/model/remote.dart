import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rental_manager_app/model/holiday.dart';
import 'dart:convert';

import 'package:rental_manager_app/model/message_scheme.dart';

class Remote  {
  static String serverUri = '192.168.0.141/';

  static Future<List<Holiday>> fetchHoliday(int year, int month, int day) async {
    // String apiKey = "eb42b5ffff294f61b59cfb7b339c1c34";
    // String country = "PL";
    //
    // var queryParams = {
    //   "api_key": apiKey,
    //   "country": country,
    //   "year": year.toString(),
    //   "month": month.toString(),
    //   "day": day.toString(),
    // };
    //
    // var uri = Uri.https("holidays.abstractapi.com", "/v1", queryParams);
    //
    // final response = await http.get("$uri");
    // if (response.statusCode == 200) {
    //
    //   List body = json.decode(response.body);
    //   List<Holiday> holidays = List();
    //   for (var i = 0; i < body.length; i++) {
    //     var holiday = Holiday.fromJson(body[i]);
    //     holidays.add(holiday);
    //   }
    //
    //   return holidays;
    // } else {
    //   print(response.body);
    //   print(response.statusCode);
    //   throw Exception('Failed to get holiday');
    // }
    return [
      Holiday(name: "Holiday 3"),
      Holiday(name: "Holiday 4"),
      Holiday(name: "Holiday 4"),
      Holiday(name: "Holiday 4"),
      Holiday(name: "Holiday 4"),
    ];
  }

  static Future<Map<DateTime, List<Holiday>>> getHolidaysInRange(DateTime start, DateTime end) async {
    // String apiKey = "eb42b5ffff294f61b59cfb7b339c1c34";
    // String country = "PL";
    //
    // Map<String, String> queryParams = {
    //   "apiKey": apiKey,
    //   "country": country,
    //   "year": start.year.toString(),
    //   "month": start.month.toString(),
    // };
    //
    // Map<DateTime, List<Holiday>> _holidays = Map();
    //
    // for (var i = 1; i <= end.day; i++) {
    //   print(i);
    //   sleep(Duration(seconds: 1));
    //   List<Holiday> h = await fetchHoliday(start.year, start.month, i);
    //   _holidays[DateTime(start.year, start.month, i)] = h;
    // }
    // print(_holidays.entries.first.value.first.name);
    // return _holidays;
    sleep(Duration(seconds: 1));
    Map<DateTime, List<Holiday>> holidays = {
      start.subtract(Duration(days: 30)): [
        Holiday(name: "Holiday 1")
      ],
      start.subtract(Duration(days: 27)): [Holiday(name: "Holiday 2")],
      start.subtract(Duration(days: 20)): [
        Holiday(name: "Holiday 3"),
        Holiday(name: "Holiday 4"),
      ],
      start.subtract(Duration(days: 16)): [Holiday(name: "Holiday 5")],
      start.subtract(Duration(days: 10)): [
        Holiday(name: "Holiday 6"),
        Holiday(name: "Holiday 7"),
        Holiday(name: "Holiday 8")
      ],
      start.subtract(Duration(days: 4)): [
        Holiday(name: "Holiday 9"),
        Holiday(name: "Holiday 10")
      ],
      start.subtract(Duration(days: 2)): [Holiday(name: "Holiday 11")],
      start: [Holiday(name: "Holiday 12"), Holiday(name: "Holiday 13")],
      start.add(Duration(days: 1)): [
        Holiday(name: "Holiday 14"),
        Holiday(name: "Holiday 15"),
        Holiday(name: "Holiday 16"),
        Holiday(name: "Holiday 17")
      ],
      start.add(Duration(days: 7)): [
        Holiday(name: "Holiday 18")
      ],
      start.add(Duration(days: 17)): [
        Holiday(name: "Holiday 19"),
        Holiday(name: "Holiday 20")
      ],
      start.add(Duration(days: 26)): [
        Holiday(name: "Holiday 21"),
        Holiday(name: "Holiday 22"),
        Holiday(name: "Holiday 23"),
        Holiday(name: "Holiday 24")
      ],
    };
    print("returning");
    return holidays;
  }

  static Future<List<MessageScheme>> getMessageSchemes() async {
    List<MessageScheme> messageSchemes = List();

    var queryParams = {
      "userID": "XOG4xKvuOBbacoZn6LFASrHHJeJ2",
    };
    var uri = Uri.http(serverUri, "/schemes", queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      for (var i = 0; i < body.length; i++) {
        messageSchemes.add(MessageScheme.fromJson(body[i]));
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return messageSchemes;
    return [
      MessageScheme("1", "text text text text text text text text text text text text text text text ", "nazwa"),
      MessageScheme("1", "text text text text text text text text text text text text text text text ", "nazwa"),
      MessageScheme("2","text2","Nazwa2")];
  }
  static Future<MessageScheme> postMessageScheme(MessageScheme scheme) async {

    var queryParams = {
      "userID": "XOG4xKvuOBbacoZn6LFASrHHJeJ2",
    };
    var uri = Uri.http(serverUri, "/schemes", queryParams);

    final response = await http.post(uri, body: scheme.toJson());

    if (response.statusCode == 200) {
      return MessageScheme.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}



class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}