import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_shop/models/order.dart';

// * This is my database class for firestore
class FirestoreDB {
  final instance = FirebaseFirestore.instance;
  final _products = FirebaseFirestore.instance.collection('products');
  final _orders = FirebaseFirestore.instance.collection('orders');
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> addOrder(Order order) {
    // Call the user's CollectionReference to add a new user
    _orders
        .add(order.toJson())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<QuerySnapshot> getAllProducts() async {
    QuerySnapshot results = await _products.get();
    return results;
  }

  void createUser(User user, String email) {
    _users.doc(user.uid).set({'email': email});
  }
}
