// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
      user: json['user'] as String,
      name: json['name'] as String,
      i18n: json['i18n'] as String,
      group: json['group'] as String,
      email: json['email'] as String,
      apiKey: json['api_key'] as String,
      active: json['active'] as bool,
      created: json['_created'] as int,
      id: json['_id'] as String,
      modified: json['_modified'] as int);
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'email': instance.email,
      'group': instance.group,
      'i18n': instance.i18n,
      'name': instance.name,
      'active': instance.active,
      'api_key': instance.apiKey,
      '_modified': instance.modified,
      '_created': instance.created,
      '_id': instance.id
    };
