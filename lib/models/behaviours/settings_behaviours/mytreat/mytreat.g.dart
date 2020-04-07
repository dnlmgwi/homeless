// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mytreat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTreat _$MyTreatFromJson(Map<String, dynamic> json) {
  return MyTreat(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MyTreatToJson(MyTreat instance) => <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson()
    };
