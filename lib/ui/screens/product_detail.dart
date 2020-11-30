import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:student_shop/models/cart_item.dart';
import 'package:student_shop/models/product.dart';

import '../widgets/cart_widget.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail({Key key, this.product}) : super(key: key);

  static const textColor = Color(0xFF3a374e);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  CartItem order;

  @override
  void initState() {
    order = CartItem(product: widget.product);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final pColor = Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: pColor,
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
            }),
        actions: [CartWidget()],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: Container(
                        height: size.height * 0.45,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Hero(
                          tag: "${widget.product.id}",
                          child: Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title(widget.product),
                          Divider(color: ProductDetail.textColor),
                          SizedBox(height: size.height * 0.02),
                          description(widget.product, size.height),
                          SizedBox(height: size.height * 0.19)
                        ],
                      ),
                    )
                  ],
                ),
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
                child: footer(size),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title(Product product) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              product.name,
              softWrap: true,
              style: TextStyle(
                  color: ProductDetail.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 3,
            child: Text(
              "N${product.price}",
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: ProductDetail.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget description(Product product, double height) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(
                color: ProductDetail.textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: height * 0.01),
          Text(
            product.description,
            softWrap: true,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            product.description,
            softWrap: true,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget footer(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        order.decrement();
                      });
                    },
                    child: Container(
                      color: Colors.white,
                      child: Icon(Icons.remove, color: ProductDetail.textColor),
                    ),
                  ),
                  Text("${order.quantity}"),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        order.increment();
                        print("Tapped");
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: ProductDetail.textColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Text("N${order.totalPrice}",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: ProductDetail.textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ),
        FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            context.read<CartController>().addToCart(order);
            print(context.read<CartController>().cart);
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
                "Add to Cart",
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
