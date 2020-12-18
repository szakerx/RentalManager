// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_scheme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageScheme _$MessageSchemeFromJson(Map<String, dynamic> json) {
  return MessageScheme(
    json['id'] as String,
    json['content'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$MessageSchemeToJson(MessageScheme instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'name': instance.name,
    };
