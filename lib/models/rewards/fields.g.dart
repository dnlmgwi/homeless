// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
      description: json['description'] as String,
      punchCost: json['punchcost'] as String,
      retail: json['retail'] as String,
      rewardName: json['rewardname'] as String,
      wholesale: json['wholesale'] as String);
}

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'rewardname': instance.rewardName,
      'punchcost': instance.punchCost,
      'retail': instance.retail,
      'wholesale': instance.wholesale,
      'description': instance.description
    };
