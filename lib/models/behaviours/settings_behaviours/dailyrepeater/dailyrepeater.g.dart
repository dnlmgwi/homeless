// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyrepeater.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyRepeater _$DailyRepeaterFromJson(Map<String, dynamic> json) {
  return DailyRepeater(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DailyRepeaterToJson(DailyRepeater instance) =>
    <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson()
    };
