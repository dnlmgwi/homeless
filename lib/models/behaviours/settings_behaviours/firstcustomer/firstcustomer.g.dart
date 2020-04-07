// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firstcustomer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirstCustomer _$FirstCustomerFromJson(Map<String, dynamic> json) {
  return FirstCustomer(
      active: json['active'] as String,
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$FirstCustomerToJson(FirstCustomer instance) =>
    <String, dynamic>{
      'active': instance.active,
      'fields': instance.fields?.toJson()
    };
