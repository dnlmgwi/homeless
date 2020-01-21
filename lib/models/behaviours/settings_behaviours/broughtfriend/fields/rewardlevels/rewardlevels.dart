import 'package:homeless/packages.dart';
part 'rewardlevels.g.dart';

@JsonSerializable(explicitToJson: true)
class RewardLevels {
  int index;

//  String '1','2','3','4','5','6','7','8','9','10';
//  var '1','2','3','4','5','6','7','8','9','10';

  RewardLevels({this.index});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RewardLevels.fromJson(Map<String, dynamic> json) =>
      _$RewardLevelsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RewardLevelsToJson(this);
}
