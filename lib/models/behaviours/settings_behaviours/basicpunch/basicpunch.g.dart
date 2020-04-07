// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basicpunch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicPunch _$BasicPunchFromJson(Map<String, dynamic> json) {
  return BasicPunch(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>),
      punch: json['punch'] == null
          ? null
          : Punch.fromJson(json['punch'] as Map<String, dynamic>));
}

Map<String, dynamic> _$BasicPunchToJson(BasicPunch instance) =>
    <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson(),
      'punch': instance.punch?.toJson()
    };
