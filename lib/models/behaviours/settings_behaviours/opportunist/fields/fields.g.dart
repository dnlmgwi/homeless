// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
      specialList: (json['speciallist'] as List)
          ?.map((e) => e == null
              ? null
              : SpecialList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'speciallist': instance.specialList?.map((e) => e?.toJson())?.toList()
    };
