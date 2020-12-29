import 'package:rental_manager_app/model/user.dart';

class MessageScheme {
  int id;
  String name;
  String content;
  User user;

  MessageScheme({this.id, this.name, this.content, this.user});

  MessageScheme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}