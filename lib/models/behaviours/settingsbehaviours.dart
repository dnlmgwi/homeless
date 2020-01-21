import 'package:homeless/packages.dart';

//Models
import 'package:homeless/models/behaviours/settings_behaviours/basicpunch/basicpunch.dart';
import 'package:homeless/models/behaviours/settings_behaviours/broughtfriend/broughtfriend.dart';
import 'package:homeless/models/behaviours/settings_behaviours/visitsregularly/visitsregularly.dart';
import 'package:homeless/models/behaviours/settings_behaviours/mostfrequent/mostfrequent.dart';
import 'package:homeless/models/behaviours/settings_behaviours/longabsence/longabsence.dart';
import 'package:homeless/models/behaviours/settings_behaviours/employeepromoter/employeepromoter.dart';
import 'package:homeless/models/behaviours/settings_behaviours/firstcustomer/firstcustomer.dart';
import 'package:homeless/models/behaviours/settings_behaviours/dailyrepeater/dailyrepeater.dart';
import 'package:homeless/models/behaviours/settings_behaviours/visitslocations/visitslocations.dart';
import 'package:homeless/models/behaviours/settings_behaviours/mytreat/mytreat.dart';
import 'package:homeless/models/behaviours/settings_behaviours/registerer/registerer.dart';
import 'package:homeless/models/behaviours/settings_behaviours/visitsLocations/visitsLocations.dart';

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

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SettingsBehaviours.fromJson(Map<String, dynamic> json) =>
      _$SettingsBehavioursFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SettingsBehavioursToJson(this);
}
