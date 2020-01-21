// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
      punches: json['punches'] as String,
      unit: json['unit'] as String,
      increment: json['increment'] as String,
      notifyCustomer: json['notifycustomer'] as String);
}

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'increment': instance.increment,
      'unit': instance.unit,
      'punches': instance.punches,
      'notifycustomer': instance.notifyCustomer
    };
