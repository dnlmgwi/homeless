// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitslocations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitsLocations _$VisitsLocationsFromJson(Map<String, dynamic> json) {
  return VisitsLocations(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$VisitsLocationsToJson(VisitsLocations instance) =>
    <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson()
    };
