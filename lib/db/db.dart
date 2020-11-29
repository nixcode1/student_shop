import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_shop/models/order.dart';

class FirestoreDB {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  Future<void> addOrder(Order order) {
    // Call the user's CollectionReference to add a new user
    return orders
        .add(order.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
