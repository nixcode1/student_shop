import 'package:json_annotation/json_annotation.dart';
import 'package:student_shop/models/cart_item.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'order.g.dart';


@JsonSerializable(explicitToJson: true)
class Order {
  Order({this.items, this.totalPrice});

  List<CartItem> items = [];
  int totalPrice = 0;
  String user;
  String address;
  String phoneNo;
  String status = "pending";
  
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
