import 'package:flutter/material.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

import 'widgets/cart_list_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Color(0xFF2d2942),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: CartBody(),
    );
  }
}

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: context.watch<CartController>().cart.map((e) => CartListWidget(order: e,)).toList(),
      ),
    );
  }
}