import 'package:homeless/models/behaviours/settings_behaviours/opportunist/fields/speciallist/speciallist.dart';
import 'package:homeless/packages.dart';
part 'fields.g.dart';

@JsonSerializable(explicitToJson: true)
class Fields {
  @JsonKey(name: 'speciallist')
  List<SpecialList> specialList;

  Fields({this.specialList});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}
