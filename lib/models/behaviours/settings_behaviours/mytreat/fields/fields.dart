import 'package:homeless/models/behaviours/settings_behaviours/mytreat/productlist/productlist.dart';
import 'package:homeless/packages.dart';
part 'fields.g.dart';

@JsonSerializable(explicitToJson: true)
class Fields {
  String punches, award;

  @JsonKey(name: 'awardpunches')
  String awardPunches;

  @JsonKey(name: 'employeesallowed')
  String employeesAllowed;

  @JsonKey(name: 'productlist')
  List<ProductList> productList;

  Fields({
    this.punches,
    this.award,
    this.awardPunches,
    this.employeesAllowed,
    this.productList,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}
