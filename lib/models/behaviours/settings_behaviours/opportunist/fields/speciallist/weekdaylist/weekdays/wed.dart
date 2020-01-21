import 'package:homeless/packages.dart';
part 'wed.g.dart';

@JsonSerializable(explicitToJson: true)
class Wednesday {
  String punches;

  Wednesday(this.punches);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Wednesday.fromJson(Map<String, dynamic> json) =>
      _$WednesdayFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$WednesdayToJson(this);
}
