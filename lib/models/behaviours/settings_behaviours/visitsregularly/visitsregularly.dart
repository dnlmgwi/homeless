import 'package:homeless/models/behaviours/settings_behaviours/visitsregularly/fields/fields.dart';
import 'package:homeless/models/behaviours/settings_behaviours/visitsregularly/punch/punch.dart';
import 'package:homeless/packages.dart';
part 'visitsregularly.g.dart';

@JsonSerializable(explicitToJson: true)
class VisitsRegularly {
  Fields fields;
  Punch punch;
  String active;

  VisitsRegularly({this.fields, this.punch, this.active});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory VisitsRegularly.fromJson(Map<String, dynamic> json) =>
      _$VisitsRegularlyFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$VisitsRegularlyToJson(this);
}
