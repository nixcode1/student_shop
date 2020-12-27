import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_shop/db/db.dart';

class Sliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
            future: FirestoreDB().getAllProducts(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              } else if (snapshot.hasData) {
                if (snapshot.data.docs.isEmpty) {
                  return Center(child: Text("Stock is Empty"));
                }
                
              }
              return Center(child: CircularProgressIndicator());
            },
          )
      ),
    );
  }
}
