import 'package:json_annotation/json_annotation.dart';

//Models
import 'package:homeless/models/behaviours/settings_behaviours/basicpunch/basicpunch.dart';
import 'package:homeless/models/behaviours/broughtfriend.dart';
import 'package:homeless/models/behaviours/visitsregularly.dart';
import 'package:homeless/models/behaviours/mostfrequent.dart';
import 'package:homeless/models/behaviours/longabsence.dart';
import 'package:homeless/models/behaviours/employeepromoter.dart';
import 'package:homeless/models/behaviours/firstcustomer.dart';
import 'package:homeless/models/behaviours/dailyrepeater.dart';
import 'package:homeless/models/behaviours/visitslocations.dart';
import 'package:homeless/models/behaviours/mytreat.dart';

part 'settingsbehaviours.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingsBehaviours {
  @JsonKey(name: 'basicpunch')
  BasicPunch basicPunch;

  @JsonKey(name: 'broughtfriend')
  BroughtFriend broughtFriend;

  @JsonKey(name: 'visitsregularly')
  VisitsRegularly visitsRegularly;

  @JsonKey(name: 'mostfrequent')
  MostFrequent mostFrequent;

  @JsonKey(name: 'longabsence')
  LongAbsence longAbsence;

  @JsonKey(name: 'employeepromoter')
  EmployeePromoter employeePromoter;

  @JsonKey(name: 'firstcustomer')
  FirstCustomer firstCustomer;

  @JsonKey(name: 'dailyrepeater')
  DailyRepeater dailyRepeater;

  Registerer registerer;

  @JsonKey(name: 'visitslocations')
  VisitsLocatons visitsLocations;

  Luckiest luckiest;

  @JsonKey(name: 'mytreat')
  Mytreat myTreat;

  Opportunist opportunist;

  SettingsBehaviours({
    this.basicPunch,
    this.broughtFriend,
    this.visitsRegularly,
    this.mostFrequent,
    this.longAbsence,
    this.employeePromoter,
    this.firstCustomer,
    this.dailyRepeater,
    this.registerer,
    this.visitsLocations,
    this.luckiest,
    this.myTreat,
    this.opportunist,
  });
}
