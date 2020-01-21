import 'package:homeless/models/behaviours/settings_behaviours/employeepromoter/fields/fields.dart';
import 'package:homeless/packages.dart';

part 'employeepromoter.g.dart';

@JsonSerializable(explicitToJson: true)
class EmployeePromoter {
  String active;
  Fields fields;

  EmployeePromoter({this.active, this.fields});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory EmployeePromoter.fromJson(Map<String, dynamic> json) =>
      _$EmployeePromoterFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$EmployeePromoterToJson(this);
}
