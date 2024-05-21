// lib/models/product.dart
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

double doubleFromJson(dynamic value) {
  if (value is String) {
    return double.tryParse(value) ?? 0.0;
  } else if (value is num) {
    return value.toDouble();
  } else {
    return 0.0;
  }
}

dynamic doubleToJson(double value) => value;

@JsonSerializable()
class Product {
  int? id;
  String name;
  @JsonKey(fromJson: doubleFromJson, toJson: doubleToJson)
  double price;
  String description;
  String imageUrl;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}