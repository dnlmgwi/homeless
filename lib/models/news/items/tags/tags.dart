import 'package:homeless/packages.dart';
part 'tags.g.dart';

/*

Sample Response
    "tags": [
              "Graphic Design"
            ],

 */

@JsonSerializable(explicitToJson: true)
class Tags {
  int index;

  Tags({this.index});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TagsToJson(this);
}
