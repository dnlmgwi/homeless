import 'package:homeless/model/rewards/settingsRewards.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rewards.g.dart';

@JsonSerializable(explicitToJson: true)
class Rewards {
  String status;
  String message;

  @JsonKey(name: 'shortcode')
  String shortCode;

  @JsonKey(name: 'settings_rewards')
  List<SettingsRewards> settingsRewards;

  Rewards({this.status, this.message, this.shortCode, this.settingsRewards});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Rewards.fromJson(Map<String, dynamic> json) =>
      _$RewardsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RewardsToJson(this);
}
