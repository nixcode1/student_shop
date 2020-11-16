import 'package:flutter/material.dart';
import 'package:student_shop/models/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({Key key, this.product}) : super(key: key);

  static const textColor = Color(0xFF3a374e);

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
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Color(0xFF2d2942),
              ),
              onPressed: () {})
        ],
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
                        height: size.height * 0.4,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Hero(
                          tag: "${product.imageUrl}",
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.height * 0.02),
                      child: Column(
                        children: [
                          title(product),
                          Divider(color: textColor),
                          SizedBox(height: size.height * 0.02),
                          description(product, size.height),
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
                  color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 3,
            child: Text(
              "#3400000",
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
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
                color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
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
                  Container(
                    color: Colors.white,
                    child: Icon(Icons.remove, color: textColor),
                  ),
                  Text("2"),
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: textColor
                    ),
                    child: Icon(Icons.add, color: Colors.white,)
                  )
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Text("Total: #230000",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ),
        FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
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
                child: Text("Add to Cart",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w900))),
          ),
        )
      ],
    );
  }
}
