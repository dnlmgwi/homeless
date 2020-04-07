// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settingsbehaviours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsBehaviours _$SettingsBehavioursFromJson(Map<String, dynamic> json) {
  return SettingsBehaviours(
      basicPunch: json['basicpunch'] == null
          ? null
          : BasicPunch.fromJson(json['basicpunch'] as Map<String, dynamic>),
      broughtFriend: json['broughtfriend'] == null
          ? null
          : BroughtFriend.fromJson(
              json['broughtfriend'] as Map<String, dynamic>),
      visitsRegularly: json['visitsregularly'] == null
          ? null
          : VisitsRegularly.fromJson(
              json['visitsregularly'] as Map<String, dynamic>),
      mostFrequent: json['mostfrequent'] == null
          ? null
          : MostFrequent.fromJson(json['mostfrequent'] as Map<String, dynamic>),
      longAbsence: json['longabsence'] == null
          ? null
          : LongAbsence.fromJson(json['longabsence'] as Map<String, dynamic>),
      employeePromoter: json['employeepromoter'] == null
          ? null
          : EmployeePromoter.fromJson(
              json['employeepromoter'] as Map<String, dynamic>),
      firstCustomer: json['firstcustomer'] == null
          ? null
          : FirstCustomer.fromJson(
              json['firstcustomer'] as Map<String, dynamic>),
      dailyRepeater: json['dailyrepeater'] == null
          ? null
          : DailyRepeater.fromJson(
              json['dailyrepeater'] as Map<String, dynamic>),
      registerer: json['registerer'] == null
          ? null
          : Registerer.fromJson(json['registerer'] as Map<String, dynamic>),
      visitsLocations: json['visitslocations'] == null
          ? null
          : VisitsLocations.fromJson(
              json['visitslocations'] as Map<String, dynamic>),
      luckiest: json['luckiest'] == null
          ? null
          : Luckiest.fromJson(json['luckiest'] as Map<String, dynamic>),
      myTreat: json['mytreat'] == null
          ? null
          : MyTreat.fromJson(json['mytreat'] as Map<String, dynamic>),
      opportunist: json['opportunist'] == null
          ? null
          : Opportunist.fromJson(json['opportunist'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SettingsBehavioursToJson(SettingsBehaviours instance) =>
    <String, dynamic>{
      'basicpunch': instance.basicPunch?.toJson(),
      'broughtfriend': instance.broughtFriend?.toJson(),
      'visitsregularly': instance.visitsRegularly?.toJson(),
      'mostfrequent': instance.mostFrequent?.toJson(),
      'longabsence': instance.longAbsence?.toJson(),
      'employeepromoter': instance.employeePromoter?.toJson(),
      'firstcustomer': instance.firstCustomer?.toJson(),
      'dailyrepeater': instance.dailyRepeater?.toJson(),
      'registerer': instance.registerer?.toJson(),
      'visitslocations': instance.visitsLocations?.toJson(),
      'luckiest': instance.luckiest?.toJson(),
      'mytreat': instance.myTreat?.toJson(),
      'opportunist': instance.opportunist?.toJson()
    };
