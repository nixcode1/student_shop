// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as String,
    price: json['price'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
    };
