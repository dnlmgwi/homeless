// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'luckiest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Luckiest _$LuckiestFromJson(Map<String, dynamic> json) {
  return Luckiest(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LuckiestToJson(Luckiest instance) => <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson()
    };
