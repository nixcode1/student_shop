import 'package:flutter/material.dart';
import 'package:student_shop/models/order.dart';

class CartController extends ChangeNotifier {
  int _count;

  List<Order> _orders = [];

  int get count => _orders.length;

  List get cart => _orders;

  int totalPrice() {
    int _totalPrice = 0;
    _orders.forEach((element) {
      _totalPrice += _totalPrice + element.totalPrice;
    });
    return _totalPrice;
  }

  void addToCart(Order order) {
    Order newOrder = _orders.firstWhere(
        (element) => element.product.id == order.product.id,
        orElse: () => null);
    if (newOrder != null) {
      incrementNotAdd(order);
    } else {
      _orders.add(order);
    }

    notifyListeners();
  }

  void incrementNotAdd(Order order) {
    int index =
        _orders.indexWhere((element) => element.product.id == order.product.id);
    _orders[index].increment();
    print(_orders[index].totalPrice);
    notifyListeners();
  }

  void decrementOrder(Order order) {
    int index =
        _orders.indexWhere((element) => element.product.id == order.product.id);
    _orders[index].decrement();
    print(_orders[index].totalPrice);

    notifyListeners();
  }
}
