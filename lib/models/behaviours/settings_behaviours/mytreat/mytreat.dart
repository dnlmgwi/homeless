import 'package:homeless/models/behaviours/settings_behaviours/mytreat/fields/fields.dart';
import 'package:homeless/packages.dart';
part 'mytreat.g.dart';

@JsonSerializable(explicitToJson: true)
class MyTreat {
  String active;
  Fields fields;

  MyTreat({this.active, this.fields});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MyTreat.fromJson(Map<String, dynamic> json) =>
      _$MyTreatFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MyTreatToJson(this);
}
