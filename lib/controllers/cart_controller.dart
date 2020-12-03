import 'package:flutter/material.dart';
import 'package:student_shop/models/cart_item.dart';
import 'package:student_shop/models/order.dart';

class CartController extends ChangeNotifier {
  int _count;
  Order order = new Order()..items = [];

  int get count => order.items.length;

  List get cart => order.items;

  int totalPrice() {
    order.totalPrice = 0;
    order.items.forEach((element) {
      order.totalPrice += order.totalPrice + element.totalPrice;
    });
    return order.totalPrice;
  }

  String addToCart(CartItem cartItem) {
    CartItem newCartItem = order.items.firstWhere(
        (element) => element.product.id == cartItem.product.id,
        orElse: () => null);
    if (newCartItem != null) {
      String message = incrementNotAdd(cartItem);
      return message;
    } else {
      order.items.add(cartItem);
      notifyListeners();
      return "Item Added!";
    }
  }

  bool removeFromCart(CartItem cartItem) {
    bool result = order.items.remove(cartItem);
    notifyListeners();
    return result;
  }

  String incrementNotAdd(CartItem cartItem) {
    int index = order.items
        .indexWhere((element) => element.product.id == cartItem.product.id);
    CartItem item = order.items[index];
    item.increment();
    print(item.totalPrice);
    notifyListeners();
    return "Item already in cart, quantity increased to ${item.quantity}";
  }

  void decrementCartItem(CartItem cartItem) {
    int index = order.items
        .indexWhere((element) => element.product.id == cartItem.product.id);
    order.items[index].decrement();
    print(order.items[index].totalPrice);
    notifyListeners();
  }

  set cartAddress(String address ){
    order.address = address;
    print("Controller cart address added");
    notifyListeners();
  }

  set phoneNo(String number) {
    order.phoneNo = number;
    notifyListeners();
  }

  
}
