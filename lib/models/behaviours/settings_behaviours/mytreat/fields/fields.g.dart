// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
      punches: json['punches'] as String,
      award: json['award'] as String,
      awardPunches: json['awardpunches'] as String,
      employeesAllowed: json['employeesallowed'] as String,
      productList: (json['productlist'] as List)
          ?.map((e) => e == null
              ? null
              : ProductList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'punches': instance.punches,
      'award': instance.award,
      'awardpunches': instance.awardPunches,
      'employeesallowed': instance.employeesAllowed,
      'productlist': instance.productList?.map((e) => e?.toJson())?.toList()
    };
