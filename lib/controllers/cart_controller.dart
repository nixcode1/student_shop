import 'package:flutter/material.dart';
import 'package:student_shop/models/cart_item.dart';
import 'package:student_shop/models/order.dart';

class CartController extends ChangeNotifier {
  int _count;
  Order order = new Order()
  ..items = [];

  int get count => order.items.length;

  List get cart => order.items;

  int totalPrice() {
    order.totalPrice = 0;
    order.items.forEach((element) {
      order.totalPrice += order.totalPrice + element.totalPrice;
    });
    return order.totalPrice;
  }

  void addToCart(CartItem cartItem) {
    CartItem newCartItem = order.items.firstWhere(
        (element) => element.product.id == cartItem.product.id,
        orElse: () => null);
    if (newCartItem != null) {
      incrementNotAdd(cartItem);
    } else {
      order.items.add(cartItem);
    }

    notifyListeners();
  }

  void incrementNotAdd(CartItem cartItem) {
    int index =
        order.items.indexWhere((element) => element.product.id == cartItem.product.id);
    order.items[index].increment();
    print(order.items[index].totalPrice);
    notifyListeners();
  }

  void decrementCartItem(CartItem cartItem) {
    int index =
        order.items.indexWhere((element) => element.product.id == cartItem.product.id);
    order.items[index].decrement();
    print(order.items[index].totalPrice);

    notifyListeners();
  }
}
