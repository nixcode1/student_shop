import 'package:flutter/material.dart';
import 'package:student_shop/models/order.dart';

class CardListWidget extends StatelessWidget {
  final Order order;

  const CardListWidget({Key key, this.order}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      width: size.width,
    );
  }
}
