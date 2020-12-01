import 'package:flutter/material.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: size.height * 0.008,
      width: size.width * 0.1,
      // decoration: BoxDecoration(
      //   color: Color(0xFF2d2942),
      //   shape: BoxShape.circle
      // ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: IconButton(
                icon: Icon(Icons.shopping_cart, color: Color(0xFF2d2942)),
                onPressed: () => Navigator.pushNamed(context, '/cart')),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(6),
              decoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: Text("${context.watch<CartController>().count}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
