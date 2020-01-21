import 'package:json_annotation/json_annotation.dart';
part 'fields.g.dart';

@JsonSerializable(explicitToJson: true)
class Fields {
  @JsonKey(name: 'rewardname')
  String rewardName;

  @JsonKey(name: 'punchcost')
  String punchCost;
  String retail;
  String wholesale;
  String description;

  Fields(
      {this.description,
      this.punchCost,
      this.retail,
      this.rewardName,
      this.wholesale});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}
