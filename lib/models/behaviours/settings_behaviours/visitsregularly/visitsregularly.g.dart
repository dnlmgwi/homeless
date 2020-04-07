// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitsregularly.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitsRegularly _$VisitsRegularlyFromJson(Map<String, dynamic> json) {
  return VisitsRegularly(
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>),
      punch: json['punch'] == null
          ? null
          : Punch.fromJson(json['punch'] as Map<String, dynamic>),
      active: json['active'] as String);
}

Map<String, dynamic> _$VisitsRegularlyToJson(VisitsRegularly instance) =>
    <String, dynamic>{
      'fields': instance.fields?.toJson(),
      'punch': instance.punch?.toJson(),
      'active': instance.active
    };
