import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_shop/models/order.dart';
import 'package:student_shop/models/product.dart';
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
    _db.collection('products').doc(id).get().then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document exists on the database');
          var data = documentSnapshot.data();
          data.remove('createdAt');
          print(json.encode(data));
        }
      },
    );
  }

  void fetchOrders() async {
    print("called");
    QuerySnapshot value =
        await _db.collection("products").where("rank", isGreaterThan: 1).get();

    List<Product> products = (value.docs.map((e) {
      Map<String, dynamic> data = e.data();
      return Product.fromJson(data);
    })).toList();
    Properties query = Properties(gpuClass: 1, cpuClass: 1, storage: "HDD");
    List<Product> queryResults =
        products.where((element) => query.compare(element.properties)).toList();
    queryResults.forEach((element) {
      print(element.toJson());
    });
  }

  void createUser(User user, {String name}) {
    AppUser dbUser = AppUser()
      ..id = user.uid
      ..name = user.displayName ?? name
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
