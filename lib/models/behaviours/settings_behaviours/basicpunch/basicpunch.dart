import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class BasicPunch {
  String active;
  Fields fields;
  Punch punch;
}
