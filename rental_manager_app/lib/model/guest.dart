import 'package:rental_manager_app/model/person.dart';
import 'package:rental_manager_app/model/user.dart';

import 'id.dart';

class Guest {
  Id id;
  User user;
  Person person;
  String note;

  Guest({this.id, this.user, this.person, this.note});

  Guest.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    person =
    json['person'] != null ? new Person.fromJson(json['person']) : null;
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.person != null) {
      data['person'] = this.person.toJson();
    }
    data['note'] = this.note;
    return data;
  }
}