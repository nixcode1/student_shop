import 'package:flutter/cupertino.dart';
import 'package:student_shop/models/order.dart';

class CartController extends ChangeNotifier {

  int _count;
  List<Order> _orders = [];

  int get count => _orders.length;

  List get cart => _orders;

  void addToCart(Order order) {
    _orders.add(order);
    notifyListeners();
  }


}