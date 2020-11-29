// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    quantity: json['quantity'] as int,
  )
    ..price = json['price'] as int
    ..total = json['total'] as int;
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'product': instance.product?.toJson(),
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
    };
