import 'package:json_annotation/json_annotation.dart';

part 'holiday.g.dart';

@JsonSerializable()
class Holiday {
  String name;
  @JsonKey(name: 'name_local')
  String nameLocal;
  String language;
  String description;
  String country;
  String location;
  String type;
  String date;
  @JsonKey(name: 'date_year')
  String dateYear;
  @JsonKey(name: 'date_month')
  String dateMonth;
  @JsonKey(name: 'date_day')
  String dateDay;
  @JsonKey(name: 'week_day')
  String weekDay;

  Holiday(
      {this.name,
        this.nameLocal,
        this.language,
        this.description,
        this.country,
        this.location,
        this.type,
        this.date,
        this.dateYear,
        this.dateMonth,
        this.dateDay,
        this.weekDay});

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
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
  Map<String, dynamic> toJson() => _$HolidayToJson(this);
}