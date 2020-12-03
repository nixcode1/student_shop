import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/controllers/user_controller.dart';
import 'package:student_shop/models/order.dart';
import 'package:student_shop/models/user_model.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
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
      body: CheckoutBody(),
    );
  }
}

class CheckoutBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cart = context.watch<CartController>();
    AppUser user = context.watch<UserController>().user;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
          child: ListView(
            padding: EdgeInsets.only(bottom: size.height * 0.18),
            children: [
              cart.order.address == null
                  ? _enterAddressBtn(context)
                  : checkOutCard(context,
                      title: "Address",
                      content: cart.order.address,
                      func: () => _showAddressBottomSheet(context)),
              cart.order.phoneNo == null
                  ? _enterNumberBtn(context)
                  : checkOutCard(context,
                      title: "Mobile Number",
                      content: cart.order.phoneNo,
                      func: () => _showNumberBottomSheet(context))
            ],
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
            // AppUser user  = await FirestoreDB().getUser();
            // print(user.email);
            // Order order = context.read<CartController>().order
            // ..address = user.address
            // ..user = user.id;
            // await dbApi.addOrder(order);
            // print(order.toJson());
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

  Widget _enterAddressBtn(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: ListTile(
        onTap: () => _showAddressBottomSheet(context),
        leading: Icon(Icons.add_circle),
        title: Text("Add an Address"),
      ),
    );
  }

  Widget _enterNumberBtn(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20,),
      child: ListTile(
        onTap: () => _showNumberBottomSheet(context),
        leading: Icon(Icons.add_circle),
        title: Text("Add a Phone Number"),
      ),
    );
  }

  Widget checkOutCard(BuildContext context,
      {String title, String content, Function func}) {
    Color accentColor = Theme.of(context).accentColor;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width * 0.4,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: size.height * 0.035,
                      width: size.width * 0.01,
                      color: accentColor,
                    ),
                    SizedBox(
                      width: size.width * 0.015,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      content,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: func,
            child: Icon(
              Icons.edit,
              color: accentColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _addressbottomSheet(BuildContext context) {
    String address = '';
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                "Enter an Address",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              labelText: "Address",
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
            ),
            onChanged: (String value) {
              address = value;
              print(address);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () async {
                // if(GetUtils.isPhoneNumber(number)) {
                //   print('yes is number');
                // } else {
                //   print('not phone number');
                // }
                context.read<UserController>().setAddress = address;
                context.read<CartController>().cartAddress = address;
                Navigator.pop(context);
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
                    "Save address",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
          context.watch<UserController>().user.phoneNo == null
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      context.read<CartController>().phoneNo = null;
                      Navigator.pop(context);
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
                          "Add address",
                          style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),
          RaisedButton(
            onPressed: () {
              context.read<CartController>().cartAddress = null;
            },
            child: Text("Clear"),
          )
        ],
      ),
    );
  }

  Widget _numberBottomSheet(BuildContext context) {
    String number = '';
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                "Enter a Mobile Number",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              labelText: "Phone Number",
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
            ),
            onChanged: (String value) {
              number = value;
              print(number);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () async {
                // if(GetUtils.isPhoneNumber(number)) {
                //   print('yes is number');
                // } else {
                //   print('not phone number');
                // }
                context.read<UserController>().setNumber = number.trim();
                context.read<CartController>().phoneNo = number.trim();
                Navigator.pop(context);
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
                    "Save number",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
          context.watch<UserController>().user.phoneNo == null
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      context.read<CartController>().phoneNo = null;
                      Navigator.pop(context);
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
                          "Add number",
                          style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 16,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),
          RaisedButton(
            onPressed: () {
              context.read<CartController>().phoneNo = null;
            },
            child: Text("Clear"),
          )
        ],
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet(
      (context) => _addressbottomSheet(context),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
    );
  }

  void _showNumberBottomSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet(
      (context) => _numberBottomSheet(context),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
    );
  }
}
