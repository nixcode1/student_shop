import 'package:flutter/cupertino.dart';

import 'product.dart';

class Order {
  Product product;
  int price;
  int quantity;

  Order({this.product, this.quantity = 1}) {
    price = product.price;
    print(price);
  }

  int get totalPrice => price * quantity;

  void increment() {
    quantity++;
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
