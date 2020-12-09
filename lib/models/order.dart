import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_shop/models/cart_item.dart';

import 'user_model.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'order.g.dart';


@JsonSerializable(explicitToJson: true)
class Order {
  Order({this.items, this.totalPrice, this.date});

  List<CartItem> items = [];
  int totalPrice = 0;
  AppUser user;
  bool isCompleted = false;
  @TimestampConverter()
  DateTime date;
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}