import 'package:homeless/models/behaviours/settings_behaviours/longabsence/fields/fields.dart';
import 'package:homeless/models/behaviours/settings_behaviours/longabsence/punch/punch.dart';
import 'package:homeless/packages.dart';
part 'longabsence.g.dart';

@JsonSerializable(explicitToJson: true)
class LongAbsence {
  String active;
  Punch punch;
  Fields fields;

  LongAbsence({this.active, this.punch, this.fields});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory LongAbsence.fromJson(Map<String, dynamic> json) =>
      _$LongAbsenceFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LongAbsenceToJson(this);
}
