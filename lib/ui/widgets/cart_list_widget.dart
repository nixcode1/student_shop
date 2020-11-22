import 'package:flutter/material.dart';
import 'package:student_shop/models/order.dart';

class CartListWidget extends StatelessWidget {
  final Order order;

  const CartListWidget({Key key, this.order}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      width: size.width,
      height: size.height * 0.2,
      color: Colors.red,
      child: Center(child: Text("${order.product.name} ${order.quantity}")),
    );
  }
}
