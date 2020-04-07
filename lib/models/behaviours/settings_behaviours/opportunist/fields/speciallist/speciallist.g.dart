// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciallist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialList _$SpecialListFromJson(Map<String, dynamic> json) {
  return SpecialList(
      json['specialname'] as String,
      json['timeofday'] as String,
      (json['timeofdaylist'] as List)
          ?.map((e) => e == null
              ? null
              : TimeOfDayList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['seasonlist'] as List)
          ?.map((e) =>
              e == null ? null : SeasonList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['weekdaylist'] == null
          ? null
          : WeekdayList.fromJson(json['weekdaylist'] as Map<String, dynamic>),
      json['specialnumber'] as String,
      json['displayorder'] as String,
      json['frequency'] as String,
      json['punches'] as String);
}

Map<String, dynamic> _$SpecialListToJson(SpecialList instance) =>
    <String, dynamic>{
      'specialname': instance.specialName,
      'timeofday': instance.timeOfDay,
      'timeofdaylist':
          instance.timeOfDayList?.map((e) => e?.toJson())?.toList(),
      'seasonlist': instance.seasonList?.map((e) => e?.toJson())?.toList(),
      'weekdaylist': instance.weekdayList?.toJson(),
      'specialnumber': instance.specialNumber,
      'displayorder': instance.displayOrder,
      'frequency': instance.frequency,
      'punches': instance.punches
    };
