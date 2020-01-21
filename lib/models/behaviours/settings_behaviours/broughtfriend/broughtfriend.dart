import 'package:homeless/models/behaviours/settings_behaviours/broughtfriend/fields/fields.dart';
import 'package:homeless/models/behaviours/settings_behaviours/broughtfriend/punch/punch.dart';
import 'package:homeless/packages.dart';

part 'broughtfriend.g.dart';

@JsonSerializable(explicitToJson: true)
class BroughtFriend {
  String active;
  Punch punch;
  Fields fields;

  BroughtFriend({this.active, this.punch, this.fields});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory BroughtFriend.fromJson(Map<String, dynamic> json) =>
      _$BroughtFriendFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BroughtFriendToJson(this);
}
