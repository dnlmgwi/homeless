// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opportunist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Opportunist _$OpportunistFromJson(Map<String, dynamic> json) {
  return Opportunist(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$OpportunistToJson(Opportunist instance) =>
    <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson()
    };
