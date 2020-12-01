import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:student_shop/models/cart_item.dart';

class CartListWidget extends StatelessWidget {
  final CartItem item;

  const CartListWidget({Key key, this.item}) : super(key: key);

  static const greyColor = Color(0xFF2D2942);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(right: 20, top: 15, bottom: 15, left: 15),
      margin: EdgeInsets.only(bottom: 15, right: 20),
      width: size.width,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 5,
            spreadRadius: 0.1,
            offset: Offset(10, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height,
            width: size.width * 0.18,
            child: Image.network(
              item.product.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: size.width * 0.45,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    item.product.name,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "N${item.totalPrice}",
                    style: TextStyle(color: Colors.grey[600]),
                  )
                ]),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        bool isDeleted = context.read<CartController>().removeFromCart(item);
                        if(isDeleted) {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Item Deleted!"), backgroundColor: Colors.green,));
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Item Not Deleted!"), backgroundColor: Colors.red,));
                        }
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                // SizedBox(width: size.width * 0.1),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          context.read<CartController>().incrementNotAdd(item),
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          item.quantity.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    //Remove Order Button
                    GestureDetector(
                      onTap: () => context
                          .read<CartController>()
                          .decrementCartItem(item),
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
