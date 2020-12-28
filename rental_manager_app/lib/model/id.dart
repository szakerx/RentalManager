class Id {
  String userId;
  int personId;

  Id({this.userId, this.personId});

  Id.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['personId'] = this.personId;
    return data;
  }
}