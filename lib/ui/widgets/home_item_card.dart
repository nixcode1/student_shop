import 'package:flutter/material.dart';
import 'package:student_shop/models/product.dart';
import 'package:student_shop/ui/screens/product_detail.dart';

class ItemCard extends StatelessWidget {
  final Product product;

  const ItemCard({Key key, this.product}) : super(key: key);

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
        margin: EdgeInsets.only(
          right: 10,
        ),
        // height: size.height * 0.3,
        // width: size.width * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 0.1,
                blurRadius: 5,
                offset: Offset(0, 5),
              )
            ]),
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.14,
              height: size.height * 0.1,
              width: size.width * 0.3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                      child: Text(
                        "Hp new 32gb Ram tekjdsrnflksdflsmdlk",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "N${product.price}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
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
                  padding: EdgeInsets.only(top: 10),
                  height: size.height * 0.13,
                  width: size.width * 0.4,
                  child: Hero(
                    tag: "${product.id + '2'}",
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
