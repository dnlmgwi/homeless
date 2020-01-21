import 'package:homeless/models/behaviours/settings_behaviours/opportunist/fields/speciallist/seasonlist/punches/punches.dart';
import 'package:homeless/packages.dart';
part 'seasonlist.g.dart';

@JsonSerializable(explicitToJson: true)
class SeasonList {
  @JsonKey(name: 'seasonname')
  String seasonName;

  @JsonKey(name: 'seasonstart')
  String seasonStart;

  @JsonKey(name: 'seasonend')
  String seasonEnd;

  List<Punches> punches;

  SeasonList({this.seasonName, this.seasonStart, this.seasonEnd, this.punches});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SeasonList.fromJson(Map<String, dynamic> json) =>
      _$SeasonListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SeasonListToJson(this);
}
