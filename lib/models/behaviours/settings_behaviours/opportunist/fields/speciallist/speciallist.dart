import 'package:homeless/models/behaviours/settings_behaviours/opportunist/fields/speciallist/seasonlist/seasonlist.dart';
import 'package:homeless/models/behaviours/settings_behaviours/opportunist/fields/speciallist/timeofdaylist/timeofdaylist.dart';
import 'package:homeless/models/behaviours/settings_behaviours/opportunist/fields/speciallist/weekdaylist/weekdaylist.dart';
import 'package:homeless/packages.dart';
part 'speciallist.g.dart';

@JsonSerializable(explicitToJson: true)
class SpecialList {
  @JsonKey(name: 'specialname')
  String specialName;

  @JsonKey(name: 'timeofday')
  String timeOfDay;

  @JsonKey(name: 'timeofdaylist')
  List<TimeOfDayList> timeOfDayList;

  @JsonKey(name: 'seasonlist')
  List<SeasonList> seasonList;

  @JsonKey(name: 'weekdaylist')
  WeekdayList weekdayList;

  @JsonKey(name: 'specialnumber')
  String specialNumber;

  @JsonKey(name: 'displayorder')
  String displayOrder;

  String frequency, punches;

  SpecialList(
    this.specialName,
    this.timeOfDay,
    this.timeOfDayList,
    this.seasonList,
    this.weekdayList,
    this.specialNumber,
    this.displayOrder,
    this.frequency,
    this.punches,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SpecialList.fromJson(Map<String, dynamic> json) =>
      _$SpecialListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SpecialListToJson(this);
}
