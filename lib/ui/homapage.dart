import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:student_shop/models/order.dart';
import 'package:student_shop/models/product.dart';
import 'package:student_shop/ui/product_detail.dart';
import 'package:student_shop/ui/provider_test.dart';
import 'package:student_shop/ui/test.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/ui/widgets/cart_widget.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget body;

  List<String> list = [
    "All",
    "Laptops",
    "Laptop accessories",
    "Laptop Bags",
    "Just saying",
    "bla bla",
    "kil bil",
  ];

  TextStyle headingStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  Widget categoryRow(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: headingStyle,
          ),
          Text(
            "See all",
          )
        ],
      ),
    );
  }

  Widget category(String title) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 0.1,
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ]),
      child: Text(title),
    );
  }

  Widget newProductsList(BuildContext context, List<Product> products) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: products
            .map((e) => NewItemCard(
                  product: e,
                ))
            .toList());
  }

  Widget featuredGrid(BuildContext context, List<Product> products) {
    final double itemHeight = MediaQuery.of(context).size.height * 0.2;
    final double itemWidth = MediaQuery.of(context).size.width * 0.4;
    return GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: itemWidth / itemHeight,
        scrollDirection: Axis.vertical,
        physics:
            NeverScrollableScrollPhysics(), // to disable GridView's scrolling
        shrinkWrap: true,
        crossAxisCount: 2,
        children: products
            .map(
              (e) => ItemCard(
                product: e,
              ),
            )
            .toList());
  }

  Widget home(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.01),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding: EdgeInsets.all(2),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: list.map((e) => category(e)).toList(),
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future: products.get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              } else if (snapshot.hasData) {
                if (snapshot.data.docs.isEmpty) {
                  return Center(child: Text("Stock is Empty"));
                }
                List<Product> products = (snapshot.data.docs.map((e) {
                  Map<String, dynamic> data = e.data();
                  return Product.fromJson(data);
                })).toList();
                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        categoryRow("New Arrivals"),
                        SizedBox(
                            height: size.height * 0.4,
                            child: newProductsList(context, products)),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        categoryRow("Featured"),
                        SizedBox(
                            height: size.height,
                            child: featuredGrid(context, products))
                      ],
                    ),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double kHeight = MediaQuery.of(context).size.height;
    double kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("TechPlug", style: TextStyle(fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.filter_list, size: 30), onPressed: _openDrawer),
        actions: [
          CartWidget()
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                setState(() {
                  body = home(context);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                //
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
          }),
      body: home(context),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Product product;

  const ItemCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 10,),
      width: size.width * 0.6,
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
            bottom: 5,
            width: size.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hp new 32gb Ram, 256GB SDD, 1080p HD 15'6'",
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "N${product.price}",
                    style: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
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
                width: size.width * 0.5,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
