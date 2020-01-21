import 'package:homeless/packages.dart';
part 'timeofdaylist.g.dart';

@JsonSerializable(explicitToJson: true)
class TimeOfDayList {
  @JsonKey(name: 'timestart')
  String timeStart;

  @JsonKey(name: 'timeend')
  String timeEnd;

  TimeOfDayList(this.timeEnd, this.timeStart);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory TimeOfDayList.fromJson(Map<String, dynamic> json) =>
      _$TimeOfDayListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TimeOfDayListToJson(this);
}
