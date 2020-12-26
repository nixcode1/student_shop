import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_shop/models/order.dart';
import 'package:student_shop/models/user_model.dart';

// * This is my database class for firestore
class FirestoreDB {
  final _db = FirebaseFirestore.instance;

  Future<void> addOrder(Order order) {
    // Set timestamp;
    Map modifiedOrder = order.toJson();
    modifiedOrder['date'] = FieldValue.serverTimestamp();

    // Call the user's CollectionReference to add a new user
    _db
        .collection("orders")
        .add(modifiedOrder)
        .then((value) => print("Order added"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  Future<QuerySnapshot> getAllProducts() async {
    QuerySnapshot results = await _db.collection("products").get();
    return results;
  }

  void fecthOrder(String id) {
    print("called!");
    _db
        .collection('products')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        print(json.encode(documentSnapshot.data()));
      }
    });
  }

  void fetchOrders() async {
    List ls = [];
    await getAllProducts().then((value) => value.docs.forEach((element) {
          ls.add(element.data());
        }));
    print(ls);
  }

  void createUser(User user) {
    AppUser dbUser = AppUser()
      ..id = user.uid
      ..name = user.displayName
      ..email = user.email
      ..phoneNo = user.phoneNumber;
    _db.collection("users").doc(user.uid).set(dbUser.toJson());
  }

  Future<AppUser> getUser() async {
    String id = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot result = await _db.collection("users").doc(id).get();
    AppUser user = AppUser.fromJson(result.data());
    print("User fectched!: ${user.email}");
    return user;
  }

  void updateUser(String id, AppUser user) {
    _db.collection("users").doc(id).update(user.toJson());
    print("${user.email}: User updated");
  }
}
