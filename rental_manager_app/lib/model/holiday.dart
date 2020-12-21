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

  factory Holiday.fromJson(Map<String, dynamic> json) => _$HolidayFromJson(json);
  Map<String, dynamic> toJson() => _$HolidayToJson(this);
}