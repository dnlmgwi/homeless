import 'package:json_annotation/json_annotation.dart';
part 'loginresponse.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  String user, email, group, i18n, name;
  bool active;
  @JsonKey(name: 'api_key')
  String apiKey;

  @JsonKey(name: '_modified')
  int modified;

  @JsonKey(name: '_created')
  int created;

  @JsonKey(name: '_id')
  String id;

  LoginResponse({
    this.user,
    this.name,
    this.i18n,
    this.group,
    this.email,
    this.apiKey,
    this.active,
    this.created,
    this.id,
    this.modified,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
