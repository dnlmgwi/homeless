import 'package:homeless/models/behaviours/settings_behaviours/dailyrepeater/fields/fields.dart';
import 'package:homeless/packages.dart';
part 'dailyrepeater.g.dart';

@JsonSerializable(explicitToJson: true)
class DailyRepeater {
  String active;
  Fields fields;

  DailyRepeater({this.active, this.fields});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory DailyRepeater.fromJson(Map<String, dynamic> json) =>
      _$DailyRepeaterFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DailyRepeaterToJson(this);
}
