import 'package:homeless/packages.dart';
part 'productlist.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductList {
  @JsonKey(name: 'productname')
  String productName;

  @JsonKey(name: 'productpunches')
  String productPunches;

  ProductList({this.productName, this.productPunches});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ProductListToJson(this);
}
