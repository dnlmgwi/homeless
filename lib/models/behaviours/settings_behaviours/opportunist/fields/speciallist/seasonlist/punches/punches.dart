import 'package:homeless/packages.dart';
part 'punches.g.dart';

@JsonSerializable(explicitToJson: true)
class Punches {
  int index;

  Punches({this.index});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Punches.fromJson(Map<String, dynamic> json) =>
      _$PunchesFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PunchesToJson(this);
}
