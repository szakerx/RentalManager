// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Holiday _$HolidayFromJson(Map<String, dynamic> json) {
  return Holiday(
    name: json['name'] as String,
    nameLocal: json['name_local'] as String,
    language: json['language'] as String,
    description: json['description'] as String,
    country: json['country'] as String,
    location: json['location'] as String,
    type: json['type'] as String,
    date: json['date'] as String,
    dateYear: json['date_year'] as String,
    dateMonth: json['date_month'] as String,
    dateDay: json['date_day'] as String,
    weekDay: json['week_day'] as String,
  );
}

Map<String, dynamic> _$HolidayToJson(Holiday instance) => <String, dynamic>{
      'name': instance.name,
      'name_local': instance.nameLocal,
      'language': instance.language,
      'description': instance.description,
      'country': instance.country,
      'location': instance.location,
      'type': instance.type,
      'date': instance.date,
      'date_year': instance.dateYear,
      'date_month': instance.dateMonth,
      'date_day': instance.dateDay,
      'week_day': instance.weekDay,
    };
