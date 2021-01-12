import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:rental_manager_app/model/holiday.dart';
import 'dart:convert';
import 'package:rental_manager_app/model/message_scheme.dart';
import 'package:rental_manager_app/model/planned_message.dart';
import 'package:rental_manager_app/model/rental_object.dart';
import 'package:rental_manager_app/model/reservation.dart';
import 'package:rental_manager_app/model/user.dart' as model;
import 'guest.dart';

class Remote {
  static String serverUri = '192.168.0.120:8080';

  static Future<model.User> postUser(model.User user) async {
    // return guest;
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/users", queryParams);

    var body = user.toJson();

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json", "Authorization": "Bearer ${await token()}"});

    if (response.statusCode == 200) {
      return model.User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Nie udało się');
    }
  }

  static Future<List<Reservation>> getReservations() async {
    List<Reservation> reservations = List();
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/reservations", queryParams);

    final response = await http.get(uri, headers: {"Authorization": "Bearer ${await token()}"});

    if (response.statusCode == 200) {
      List body = jsonDecode(utf8.decode(response.bodyBytes));
      for (var i = 0; i < body.length; i++) {
        reservations.add(Reservation.fromJson(body[i]));
      }
    } else {
      throw Exception('Nie udało się pobrać rezerwacji');
    }
    return reservations;
  }
  static Future<Reservation> postReservation(Reservation reservation) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/reservations", queryParams);

    var body = reservation.toJson();

    print(queryParams);
    print(jsonEncode(body));

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json", "Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Reservation.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Nie udało się');
    }
  }
  static Future<String> deleteReservation(Reservation reservation) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/reservations/${reservation.id}", queryParams);

    final response = await http.delete(uri, headers: {"Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return "";
    } else {
      throw Exception('Nie udało się');
    }
  }

  static Future<List<RentalObject>> getRentalObjects() async {
    List<RentalObject> rentalobjects = List();
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/rentalobjects", queryParams);

    final response = await http.get(uri, headers: {"Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String bodyUtf = utf8.decode(response.bodyBytes);
      List body = jsonDecode(bodyUtf);
      for (var i = 0; i < body.length; i++) {
        rentalobjects.add(RentalObject.fromJson(body[i]));
      }
    } else {
      throw Exception('Nie udało się');
    }
    return rentalobjects;
  }
  static Future<RentalObject> postRentalObject(RentalObject object) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/rentalobjects", queryParams);

    var body = object.toJson();

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json", "Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return RentalObject.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Nie udało się');
    }
  }
  static Future<String> deleteRentalObject(RentalObject object) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/rentalobjects/${object.id}", queryParams);

    final response = await http.delete(uri, headers: {"Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);
    print(FirebaseAuth.instance.currentUser.uid);
    await token().then((value) => print(value));
    if (response.statusCode == 200) {
      return "";
    } else {
      throw Exception('Nie udało się');
    }
  }

  static Future<List<Guest>> getGuests() async {
    List<Guest> guests = List();
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/guests", queryParams);

    final response = await http.get(uri, headers: {"Authorization": "Bearer ${await token()}"});

    if (response.statusCode == 200) {
      String bodyUtf = utf8.decode(response.bodyBytes);
      List body = jsonDecode(bodyUtf);
      for (var i = 0; i < body.length; i++) {
        guests.add(Guest.fromJson(body[i]));
      }
    } else {
      throw Exception('Nie udało się');
    }
    return guests;
  }
  static Future<Guest> postGuest(Guest guest) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/guests", queryParams);

    var body = guest.toJson();

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json", "Authorization": "Bearer ${await token()}"});

    if (response.statusCode == 200) {
      return Guest.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Nie udało się');
    }
  }
  static Future<Guest> putGuest(Guest guest) async {
    // return guest;
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/guests", queryParams);

    var body = guest.toJson();

    print(jsonEncode(body));

    final response = await http.put(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json", "Authorization": "Bearer ${await token()}"});

    print("status code: ${response.statusCode}");
    print(response.body);

    if (response.statusCode == 200) {
      return Guest.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Nie udało się');
    }
  }
  static Future<String> deleteGuest(Guest guest) async {
    // return "";
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/guests/${guest.id.personId}", queryParams);

    final response = await http.delete(uri, headers: {"Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return "";
    } else {
      throw Exception('Nie udało się');
    }
  }

  static Future<List<MessageScheme>> getMessageSchemes() async {
    List<MessageScheme> messageSchemes = List();
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/schemes", queryParams);

    final response = await http.get(uri, headers: {"Authorization": "Bearer ${await token()}"});

    if (response.statusCode == 200) {
      List body = jsonDecode(utf8.decode(response.bodyBytes));
      for (var i = 0; i < body.length; i++) {
        messageSchemes.add(MessageScheme.fromJson(body[i]));
      }
    } else {
      throw Exception('Nie udało się pobrać schematu wiadomości');
    }
    return messageSchemes;
  }
  static Future<MessageScheme> postMessageScheme(MessageScheme scheme) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/schemes", queryParams);

    var body = scheme.toJson();

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json", "Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return MessageScheme.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Nie udało się');
    }
  }
  static Future<String> deleteMessageScheme(MessageScheme scheme) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/schemes/${scheme.id}", queryParams);

    final response = await http.delete(uri, headers: {"Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return "";
    } else {
      throw Exception('Nie udało się');
    }
  }

  static Future<List<PlannedMessage>> getPlannedMessagesForReservation(
      int reservationId) async {
    List<PlannedMessage> plannedMessages = List();
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
      "reservationId": reservationId.toString()
    };
    var uri = Uri.http(serverUri, "/plannedmessages", queryParams);

    final response = await http.get(uri, headers: {"Authorization": "Bearer ${await token()}"});

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      String bodyUtf = utf8.decode(response.bodyBytes);
      List body = jsonDecode(bodyUtf);
      for (var i = 0; i < body.length; i++) {
        plannedMessages.add(PlannedMessage.fromJson(body[i]));
      }
    } else {
      throw Exception('Nie udało się');
    }
    return plannedMessages;
  }
  static Future<PlannedMessage> postPlannedMessage(PlannedMessage scheme) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/plannedmessages", queryParams);

    var body = scheme.toJson();

    print(body);

    final response = await http.post(uri,
        body: jsonEncode(body), headers: {"Content-Type": "application/json", "Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return PlannedMessage.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Nie udało się');
    }
  }
  static Future<String> deletePlannedMessage(PlannedMessage scheme) async {
    var queryParams = {
      "userId": FirebaseAuth.instance.currentUser.uid,
    };
    var uri = Uri.http(serverUri, "/plannedmessages/${scheme.id}", queryParams);

    final response = await http.delete(uri, headers: {"Authorization": "Bearer ${await token()}"});

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return "";
    } else {
      throw Exception('Nie udało się');
    }
  }

  static Future<String> token() async {
    String result = await FirebaseAuth.instance.currentUser.getIdToken();
    return result;
  }
}
