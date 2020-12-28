import 'package:rental_manager_app/model/user.dart';

class RentalObject {
  int id;
  int maxGuest;
  String description;
  String name;
  String type;
  bool allowedAnimals;
  User user;

  RentalObject(
      {this.id,
        this.maxGuest,
        this.description,
        this.name,
        this.type,
        this.allowedAnimals,
        this.user});

  RentalObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maxGuest = json['maxGuest'];
    description = json['description'];
    name = json['name'];
    type = json['type'];
    allowedAnimals = json['allowedAnimals'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['maxGuest'] = this.maxGuest;
    data['description'] = this.description;
    data['name'] = this.name;
    data['type'] = this.type;
    data['allowedAnimals'] = this.allowedAnimals;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}