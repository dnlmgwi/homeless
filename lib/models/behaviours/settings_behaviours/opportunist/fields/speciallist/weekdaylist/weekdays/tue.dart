import 'package:homeless/packages.dart';
part 'tue.g.dart';

@JsonSerializable(explicitToJson: true)
class Tuesday {
  String punches;

  Tuesday(this.punches);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Tuesday.fromJson(Map<String, dynamic> json) =>
      _$TuesdayFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TuesdayToJson(this);
}
