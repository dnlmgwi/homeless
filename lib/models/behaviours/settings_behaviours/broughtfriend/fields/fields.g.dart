// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return Fields(
      rewardLevels: json['rewardlevels'] == null
          ? null
          : RewardLevels.fromJson(
              json['rewardlevels'] as Map<String, dynamic>));
}

Map<String, dynamic> _$FieldsToJson(Fields instance) =>
    <String, dynamic>{'rewardlevels': instance.rewardLevels?.toJson()};
