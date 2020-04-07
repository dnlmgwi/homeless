// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekdaylist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekdayList _$WeekdayListFromJson(Map<String, dynamic> json) {
  return WeekdayList(
      monday: json['monday'] == null
          ? null
          : Monday.fromJson(json['monday'] as Map<String, dynamic>),
      tuesday: json['tuesday'] == null
          ? null
          : Tuesday.fromJson(json['tuesday'] as Map<String, dynamic>),
      wednesday: json['wednesday'] == null
          ? null
          : Wednesday.fromJson(json['wednesday'] as Map<String, dynamic>),
      thursday: json['thursday'] == null
          ? null
          : Thursday.fromJson(json['thursday'] as Map<String, dynamic>),
      friday: json['friday'] == null
          ? null
          : Friday.fromJson(json['friday'] as Map<String, dynamic>),
      saturday: json['saturday'] == null
          ? null
          : Saturday.fromJson(json['saturday'] as Map<String, dynamic>),
      sunday: json['sunday'] == null
          ? null
          : Sunday.fromJson(json['sunday'] as Map<String, dynamic>));
}

Map<String, dynamic> _$WeekdayListToJson(WeekdayList instance) =>
    <String, dynamic>{
      'monday': instance.monday?.toJson(),
      'tuesday': instance.tuesday?.toJson(),
      'wednesday': instance.wednesday?.toJson(),
      'thursday': instance.thursday?.toJson(),
      'friday': instance.friday?.toJson(),
      'saturday': instance.saturday?.toJson(),
      'sunday': instance.sunday?.toJson()
    };
