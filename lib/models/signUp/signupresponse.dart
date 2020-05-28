import 'package:json_annotation/json_annotation.dart';
part 'signupresponse.g.dart';

//Sample Response
/* {
user: TestingPerson,
name: Tester User,
email: testingUser1@gmail.com,
active: ,
group: Manager,
i18n: en,
_modified: 1590322933,
_created: 1590322933,
_id: 5eca66f630373142e200036c
}*/

@JsonSerializable(explicitToJson: true)
class SignUpResponse {
  String user, name, email, group, i18n, active;

  @JsonKey(name: '_modified')
  int modified;

  @JsonKey(name: '_created')
  int created;

  @JsonKey(name: '_id')
  String id;

  SignUpResponse({
    this.user,
    this.name,
    this.i18n,
    this.group,
    this.email,
    this.active,
    this.created,
    this.id,
    this.modified,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}
