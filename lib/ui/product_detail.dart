import 'package:flutter/material.dart';
import 'package:student_shop/models/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({Key key, this.product}) : super(key: key);

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
            icon: Icon(
              Icons.arrow_back,
              color: pColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: pColor,
              ),
              onPressed: () {})
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.5,
              child: Container(
                height: size.height * 0.4,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      softWrap: true,
                    ),
                    Flexible(child: FractionallySizedBox(heightFactor: 0.1)),
                    Container(
                      height: size.height * 0.1,
                      width: size.width,
                      child: Text(
                        product.description,
                        softWrap: true,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                child: SizedBox(
                  height: size.height * 0.5,
                  width: size.width,
                  child: Hero(
                    tag: "${product.imageUrl}",
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.15,
                width: size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
