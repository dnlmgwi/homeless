import 'package:homeless/packages.dart';

import 'package:homeless/models/behaviours/settings_behaviours/basicpunch/fields/fields.dart';
import 'package:homeless/models/behaviours/settings_behaviours/basicpunch/punch/punch.dart';

part 'basicpunch.g.dart';

@JsonSerializable(explicitToJson: true)
class BasicPunch {
  String active;
  Fields fields;
  Punch punch;

  BasicPunch({this.active, this.fields, this.punch});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory BasicPunch.fromJson(Map<String, dynamic> json) =>
      _$BasicPunchFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BasicPunchToJson(this);
}
