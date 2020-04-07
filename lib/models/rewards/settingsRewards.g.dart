// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settingsRewards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsRewards _$SettingsRewardsFromJson(Map<String, dynamic> json) {
  return SettingsRewards(
      fields: json['fields'] == null
          ? null
          : Fields.fromJson(json['fields'] as Map<String, dynamic>),
      active: json['active'] as String);
}

Map<String, dynamic> _$SettingsRewardsToJson(SettingsRewards instance) =>
    <String, dynamic>{
      'fields': instance.fields?.toJson(),
      'active': instance.active
    };
