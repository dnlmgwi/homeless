import 'package:homeless/model/rewards/fields.dart';
import 'package:json_annotation/json_annotation.dart';
part 'settingsRewards.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingsRewards {
  Fields fields;
  String active;

  SettingsRewards({this.fields, this.active});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SettingsRewards.fromJson(Map<String, dynamic> json) =>
      _$SettingsRewardsFromJson(json);

//  factory SettingsRewards.fromJson(Map<String,dynamic> json) {
//    return SettingsRewards(
//        fields: json.map(f) => Fields.fromJson(f as Map<String, dynamic>));
//  }

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SettingsRewardsToJson(this);
}
