// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seasonlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonList _$SeasonListFromJson(Map<String, dynamic> json) {
  return SeasonList(
      seasonName: json['seasonname'] as String,
      seasonStart: json['seasonstart'] as String,
      seasonEnd: json['seasonend'] as String,
      punches: (json['punches'] as List)
          ?.map((e) =>
              e == null ? null : Punches.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SeasonListToJson(SeasonList instance) =>
    <String, dynamic>{
      'seasonname': instance.seasonName,
      'seasonstart': instance.seasonStart,
      'seasonend': instance.seasonEnd,
      'punches': instance.punches?.map((e) => e?.toJson())?.toList()
    };
