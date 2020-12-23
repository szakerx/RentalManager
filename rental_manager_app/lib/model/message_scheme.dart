import 'package:json_annotation/json_annotation.dart';

part 'message_scheme.g.dart';

@JsonSerializable()
class MessageScheme {
  MessageScheme(this.id, this.content, this.name);

  String id;
  String content;
  String name;

  factory MessageScheme.fromJson(Map<String, dynamic> json) => _$MessageSchemeFromJson(json);
  Map<String, dynamic> toJson() => _$MessageSchemeToJson(this);
}