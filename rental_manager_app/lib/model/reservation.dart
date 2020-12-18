import 'package:json_annotation/json_annotation.dart';

part 'reservation.g.dart';

@JsonSerializable()
class Reservation {
  Reservation(this.id, this.guest, this.rentalObject, this.startDate, this.endDate, this.description, this.guestsCount, this.childrenCount, this.price);

  String id;
  @JsonKey(name: 'guest')
  String guest;
  @JsonKey(name: 'rental_object')
  String rentalObject;
  @JsonKey(name: 'start_date')
  DateTime startDate;
  @JsonKey(name: 'end_date')
  DateTime endDate;
  String description;
  @JsonKey(name: 'guests_count')
  int guestsCount;
  @JsonKey(name: 'children_count')
  int childrenCount;
  double price;

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationToJson(this);
}