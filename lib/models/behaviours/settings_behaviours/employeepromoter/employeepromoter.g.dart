// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeepromoter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeePromoter _$EmployeePromoterFromJson(Map<String, dynamic> json) {
  return EmployeePromoter(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$EmployeePromoterToJson(EmployeePromoter instance) =>
    <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson()
    };
