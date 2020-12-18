// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
    json['id'] as String,
    json['guest'] as String,
    json['rental_object'] as String,
    json['start_date'] == null
        ? null
        : DateTime.parse(json['start_date'] as String),
    json['end_date'] == null
        ? null
        : DateTime.parse(json['end_date'] as String),
    json['description'] as String,
    json['guests_count'] as int,
    json['children_count'] as int,
    (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'guest': instance.guest,
      'rental_object': instance.rentalObject,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'description': instance.description,
      'guests_count': instance.guestsCount,
      'children_count': instance.childrenCount,
      'price': instance.price,
    };
