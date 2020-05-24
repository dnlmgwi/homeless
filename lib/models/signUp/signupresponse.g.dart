// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signupresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) {
  return SignUpResponse(
      user: json['user'] as String,
      name: json['name'] as String,
      i18n: json['i18n'] as String,
      group: json['group'] as String,
      email: json['email'] as String,
      active: json['active'] as String,
      created: json['_created'] as int,
      id: json['_id'] as String,
      modified: json['_modified'] as int);
}

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'name': instance.name,
      'email': instance.email,
      'group': instance.group,
      'i18n': instance.i18n,
      'active': instance.active,
      '_modified': instance.modified,
      '_created': instance.created,
      '_id': instance.id
    };
