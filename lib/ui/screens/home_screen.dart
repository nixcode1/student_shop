import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/controllers/drawerController.dart';
import 'package:student_shop/db/db.dart';
import 'package:student_shop/models/product.dart';
import 'package:student_shop/ui/widgets/cart_widget.dart';
import 'package:student_shop/ui/widgets/home_item_card.dart';

import '../widgets/home_new_item.dart';

class HomeScreen extends StatelessWidget {
  final TextStyle headingStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final FirestoreDB _db = FirestoreDB();

  final List<String> list = [
    "All",
    "Laptops",
    "Laptop accessories",
    "Laptop Bags",
    "Just saying",
    "bla bla",
    "kil bil",
  ];

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
    // return StaggeredGridView.countBuilder(
    //   physics: NeverScrollableScrollPhysics(),
    //   crossAxisCount: 3,
    //   itemCount: products.length,
    //   itemBuilder: (BuildContext context, int index) =>
    //       ItemCard(product: products[index]),
    //   staggeredTileBuilder: (int index) =>
    //       new StaggeredTile.count(2, index.isEven ? 2 : 1),
    //   mainAxisSpacing: 4.0,
    //   crossAxisSpacing: 4.0,
    // );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Store", style: TextStyle(fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: context.watch<CustomDrawerController>().isDrawerOpen
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 25),
                onPressed: () =>
                    context.read<CustomDrawerController>().closeDrawer(),
              )
            : IconButton(
                icon: Icon(Icons.filter_list, size: 30),
                onPressed: () =>
                    context.read<CustomDrawerController>().openDrawer(size),
              ),
        actions: [CartWidget()],
      ),
      body: Container(
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
              future: _db.getAllProducts(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
      ),
    );
  }
}
