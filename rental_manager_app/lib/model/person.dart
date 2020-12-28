
class Person {
  int id;
  String name;
  String surname;
  String phone;
  String mail;

  Person({this.id, this.name, this.surname, this.phone, this.mail});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    phone = json['phone'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['phone'] = this.phone;
    data['mail'] = this.mail;
    return data;
  }
}
