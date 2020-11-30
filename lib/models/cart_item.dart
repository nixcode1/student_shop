import 'package:json_annotation/json_annotation.dart';
import 'product.dart';

part 'cart_item.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItem {

  @JsonKey(ignore: true)
  Product product;
  String name;
  int price;
  int quantity;
  int total = 0;

  CartItem({this.product, this.quantity = 1}) {
    price = product.price;
    name = product.name;
    print(price);
  }

  int get totalPrice => total =  price * quantity;

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
