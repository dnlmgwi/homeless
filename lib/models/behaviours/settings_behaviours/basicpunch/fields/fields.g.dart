// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
      punches: json['punches'] as String,
      unit: json['unit'] as String,
      noMoreThan: json['nomorethan'] as String,
      employeeBonus: json['employeebonus'] as String,
      multiPunch: json['multipunch'] as String);
}

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'punches': instance.punches,
      'unit': instance.unit,
      'nomorethan': instance.noMoreThan,
      'employeebonus': instance.employeeBonus,
      'multipunch': instance.multiPunch
    };
