// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registerer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registerer _$RegistererFromJson(Map<String, dynamic> json) {
  return Registerer(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$RegistererToJson(Registerer instance) =>
    <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson()
    };
