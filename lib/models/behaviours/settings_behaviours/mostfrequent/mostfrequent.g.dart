// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mostfrequent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MostFrequent _$MostFrequentFromJson(Map<String, dynamic> json) {
  return MostFrequent(
      active: json['active'] as String,
      punch: json['punch'] == null
          ? null
          : Punch.fromJson(json['punch'] as Map<String, dynamic>),
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MostFrequentToJson(MostFrequent instance) =>
    <String, dynamic>{
      'active': instance.active,
      'punch': instance.punch?.toJson(),
      'fields': instance.fields?.toJson()
    };
