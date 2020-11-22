import 'package:flutter/material.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:student_shop/models/order.dart';
import 'package:provider/provider.dart';

class CartListWidget extends StatelessWidget {
  final Order order;

  const CartListWidget({Key key, this.order}) : super(key: key);

  static const greyColor = Color(0xFF2D2942);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 10),
      width: size.width,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[300],
              blurRadius: 15,
              spreadRadius: 0.5,
              offset: Offset(10, 15))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height,
            width: size.width * 0.18,
            child: Image.network(
              order.product.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: size.width * 0.5,
            child: Text(
              order.product.name,
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.read<CartController>().addToCart(order),
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: greyColor, borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    order.quantity.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<CartController>().addToCart(order),
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 15,
                          spreadRadius: 0.5,
                          offset: Offset(5, 6))
                    ],
                  ),
                  child: Icon(
                    Icons.remove,
                    color: greyColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
