// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeofdaylist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeOfDayList _$TimeOfDayListFromJson(Map<String, dynamic> json) {
  return TimeOfDayList(json['timeend'] as String, json['timestart'] as String);
}

Map<String, dynamic> _$TimeOfDayListToJson(TimeOfDayList instance) =>
    <String, dynamic>{
      'timestart': instance.timeStart,
      'timeend': instance.timeEnd
    };
