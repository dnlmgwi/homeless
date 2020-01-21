import 'package:homeless/packages.dart';
part 'sat.g.dart';

@JsonSerializable(explicitToJson: true)
class Saturday {
  String punches;

  Saturday(this.punches);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Saturday.fromJson(Map<String, dynamic> json) =>
      _$SaturdayFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SaturdayToJson(this);
}
