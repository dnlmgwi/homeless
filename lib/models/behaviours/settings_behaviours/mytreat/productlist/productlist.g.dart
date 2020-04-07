// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map<String, dynamic> json) {
  return ProductList(
      productName: json['productname'] as String,
      productPunches: json['productpunches'] as String);
}

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'productname': instance.productName,
      'productpunches': instance.productPunches
    };
