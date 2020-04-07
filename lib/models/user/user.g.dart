// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      user: json['user'] as String,
      email: json['email'] as String,
      group: json['group'] as String,
      name: json['name'] as String,
      active: json['active'] as bool,
      i18n: json['i18n'] as String,
      created: json['_created'] as int,
      modified: json['_modified'] as int,
      id: json['_id'] as String,
      apikey: json['api_key'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user': instance.user,
      'email': instance.email,
      'group': instance.group,
      'name': instance.name,
      'i18n': instance.i18n,
      'active': instance.active,
      '_created': instance.created,
      '_modified': instance.modified,
      '_id': instance.id,
      'api_key': instance.apikey
    };
