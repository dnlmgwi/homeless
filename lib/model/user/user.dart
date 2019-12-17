import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

/* {user: admin,
email: pdmgawi@gmail.com,
group: admin, name: Daniel Mgawi,
active: true,
i18n: en,
_created: 1576244358,
_modified: 1576244907,
_id: 5df39486616362b993000290,
api_key: account-82339d17e13c6706e3048c407f78ea
}
*/

@JsonSerializable(explicitToJson: true)
class User {
  String user, email, group, name, i18n;
  bool active;

  @JsonKey(name: '_created')
  int created;

  @JsonKey(name: '_modified')
  int modified;

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'api_key')
  String apikey;

  User(
      {this.user,
      this.email,
      this.group,
      this.name,
      this.active,
      this.i18n,
      this.created,
      this.modified,
      this.id,
      this.apikey});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
