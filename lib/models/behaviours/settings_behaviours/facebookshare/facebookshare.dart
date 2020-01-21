import 'package:homeless/models/behaviours/settings_behaviours/facebookshare/fields/fields.dart';
import 'package:homeless/models/behaviours/settings_behaviours/facebookshare/punch/punch.dart';
import 'package:homeless/packages.dart';
part 'facebookshare.g.dart';

@JsonSerializable(explicitToJson: true)
class FacebookShare {
  String active;
  Punch punch;
  Fields fields;

  FacebookShare({this.active, this.punch, this.fields});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory FacebookShare.fromJson(Map<String, dynamic> json) =>
      _$FacebookShareFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FacebookShareToJson(this);
}
