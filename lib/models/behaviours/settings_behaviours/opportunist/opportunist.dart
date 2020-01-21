import 'package:homeless/models/behaviours/settings_behaviours/opportunist/fields/fields.dart';
import 'package:homeless/packages.dart';
part 'opportunist.g.dart';

@JsonSerializable(explicitToJson: true)
class Opportunist {
  String active;
  Fields fields;

  Opportunist({this.active, this.fields});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Opportunist.fromJson(Map<String, dynamic> json) =>
      _$OpportunistFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$OpportunistToJson(this);
}
