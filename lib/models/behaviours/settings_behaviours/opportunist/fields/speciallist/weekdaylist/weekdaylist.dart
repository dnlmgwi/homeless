import 'package:homeless/packages.dart';
import 'package:homeless/models/behaviours/settings_behaviours/opportunist/fields/speciallist/weekdaylist/days.dart';
part 'weekdaylist.g.dart';

@JsonSerializable(explicitToJson: true)
class WeekdayList {
  Monday monday;
  Tuesday tuesday;
  Wednesday wednesday;
  Thursday thursday;
  Friday friday;
  Saturday saturday;
  Sunday sunday;

  WeekdayList({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory WeekdayList.fromJson(Map<String, dynamic> json) =>
      _$WeekdayListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$WeekdayListToJson(this);
}
