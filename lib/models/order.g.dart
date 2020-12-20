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
  )
    ..user = json['user'] == null
        ? null
        : AppUser.fromJson(json['user'] as Map<String, dynamic>)
    ..isCompleted = json['isCompleted'] as bool;
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'totalPrice': instance.totalPrice,
      'user': instance.user?.toJson(),
      'isCompleted': instance.isCompleted,
    };
