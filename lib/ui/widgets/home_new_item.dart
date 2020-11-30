import 'package:flutter/material.dart';
import 'package:student_shop/models/product.dart';

import '../screens/product_detail.dart';

class NewItemCard extends StatelessWidget {
  final Product product;

  const NewItemCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductDetail(
                      product: product,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, bottom: 5),
        width: size.width * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 0.1,
                blurRadius: 5,
                offset: Offset(5, 10),
              )
            ]),
        child: Stack(
          children: [
            Positioned(
              bottom: 5,
              width: size.width * 0.6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "N${product.price}",
                      style: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: size.height * 0.3,
                  width: size.width * 0.6,
                  child: Hero(
                    tag: "${product.id}",
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
