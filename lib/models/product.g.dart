// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      price: doubleFromJson(json['price']),
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': doubleToJson(instance.price),
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
