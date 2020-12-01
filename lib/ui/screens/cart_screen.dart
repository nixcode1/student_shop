import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/auth/auth_api.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:student_shop/db/db.dart';
import 'package:student_shop/models/order.dart';
import 'package:student_shop/models/user_model.dart';

import '../widgets/cart_list_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
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
  FirestoreDB dbApi = FirestoreDB();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        context.watch<CartController>().count < 1? Center(child: Text("Cart is empty")) : Container(
          padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
          child: ListView(
            padding: EdgeInsets.only(bottom: size.height * 0.18),
            children: context
                .watch<CartController>()
                .cart
                .map((e) => CartListWidget(
                      item: e,
                    ))
                .toList(),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: size.height * 0.18,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  spreadRadius: 0.1,
                  blurRadius: 5,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: footer(size, context),
          ),
        ),
      ],
    );
  }

  Widget footer(Size size, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Text(
                  "Items in Cart: ${context.watch<CartController>().count}",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Text(
                  "Total: N${context.watch<CartController>().totalPrice()}",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            )
          ],
        ),
        FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () async {
            String id = Auth().instance.currentUser.uid;
            print("user id + $id");
            AppUser user  = await FirestoreDB().getUser(id);
            print(user.email);
            Order order = context.read<CartController>().order
            ..address = user.address
            ..user = id;
            await dbApi.addOrder(order);
            print(order.toJson());
          },
          child: Container(
            height: size.height * 0.075,
            width: size.width,
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [Color(0xFF5d5778), Color(0xFF2d2942)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Checkout",
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        )
      ],
    );
  }
}
