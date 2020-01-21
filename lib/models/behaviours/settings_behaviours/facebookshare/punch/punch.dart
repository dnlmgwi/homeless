import 'package:homeless/packages.dart';
part 'punch.g.dart';

@JsonSerializable(explicitToJson: true)
class Punch {
  String month;

  Punch({this.month});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Punch.fromJson(Map<String, dynamic> json) => _$PunchFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$PunchToJson(this);
}
