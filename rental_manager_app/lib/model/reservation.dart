import 'package:rental_manager_app/model/person.dart';
import 'package:rental_manager_app/model/rental_object.dart';
import 'package:rental_manager_app/model/user.dart';

class Reservation {
  int id;
  String startDate;
  String endDate;
  String description;
  int guestsCount;
  int childrenCount;
  int price;
  Person person;
  RentalObject rentalObject;
  User user;

  Reservation(
      {this.id,
        this.startDate,
        this.endDate,
        this.description,
        this.guestsCount,
        this.childrenCount,
        this.price,
        this.person,
        this.rentalObject,
        this.user});

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    description = json['description'];
    guestsCount = json['guestsCount'];
    childrenCount = json['childrenCount'];
    price = json['price'];
    person =
    json['person'] != null ? new Person.fromJson(json['person']) : null;
    rentalObject = json['rentalObject'] != null
        ? new RentalObject.fromJson(json['rentalObject'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['description'] = this.description;
    data['guestsCount'] = this.guestsCount;
    data['childrenCount'] = this.childrenCount;
    data['price'] = this.price;
    if (this.person != null) {
      data['person'] = this.person.toJson();
    }
    if (this.rentalObject != null) {
      data['rentalObject'] = this.rentalObject.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
