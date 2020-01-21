import 'package:homeless/packages.dart';

part 'mon.g.dart';

@JsonSerializable(explicitToJson: true)
class Monday {
  String punches;

  Monday(this.punches);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Monday.fromJson(Map<String, dynamic> json) => _$MondayFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MondayToJson(this);
}
