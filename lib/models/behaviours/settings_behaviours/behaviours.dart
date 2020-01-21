import 'package:json_annotation/json_annotation.dart';
import 'package:homeless/models/behaviours/settingsbehaviours.dart';
part '../behaviours.g.dart';

@JsonSerializable(explicitToJson: true)
class Behaviours {
  String status;
  String message;

  @JsonKey(name: 'shortcode')
  String shortCode;

  @JsonKey(name: 'settings_behaviours')
  SettingsBehaviours settingsBehaviours;

  Behaviours(
      {this.status, this.message, this.shortCode, this.settingsBehaviours});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Behaviours.fromJson(Map<String, dynamic> json) =>
      _$BehavioursFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BehavioursToJson(this);
}
