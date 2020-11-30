// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    quantity: json['quantity'] as int,
  )
    ..name = json['name'] as String
    ..price = json['price'] as int
    ..total = json['total'] as int;
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
    };
