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
    ..user = json['user'] as String
    ..address = json['address'] as String
    ..phoneNo = json['phoneNo'] as String
    ..status = json['status'] as String;
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
      'totalPrice': instance.totalPrice,
      'user': instance.user,
      'address': instance.address,
      'phoneNo': instance.phoneNo,
      'status': instance.status,
    };
