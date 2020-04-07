// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rewards _$RewardsFromJson(Map<String, dynamic> json) {
  return Rewards(
      status: json['status'] as String,
      message: json['message'] as String,
      shortCode: json['shortcode'] as String,
      settingsRewards: (json['settings_rewards'] as List)
          ?.map((e) => e == null
              ? null
              : SettingsRewards.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RewardsToJson(Rewards instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'shortcode': instance.shortCode,
      'settings_rewards':
          instance.settingsRewards?.map((e) => e?.toJson())?.toList()
    };
