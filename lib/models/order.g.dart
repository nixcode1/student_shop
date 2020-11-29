// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    items: (json['items'] as List)
        ?.map((e) =>
            e == null ? null : CartItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    totalPrice: json['totalPrice'] as int,
  );
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'totalPrice': instance.totalPrice,
    };
