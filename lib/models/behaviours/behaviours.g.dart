// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'behaviours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Behaviours _$BehavioursFromJson(Map<String, dynamic> json) {
  return Behaviours(
      status: json['status'] as String,
      message: json['message'] as String,
      shortCode: json['shortcode'] as String,
      settingsBehaviours: json['settings_behaviours'] == null
          ? null
          : SettingsBehaviours.fromJson(
              json['settings_behaviours'] as Map<String, dynamic>));
}

Map<String, dynamic> _$BehavioursToJson(Behaviours instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'shortcode': instance.shortCode,
      'settings_behaviours': instance.settingsBehaviours?.toJson()
    };
