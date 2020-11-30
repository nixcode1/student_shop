import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_shop/models/order.dart';
import 'package:student_shop/models/user_model.dart';

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

  void createUser(AppUser user) {
    _users.doc(user.id).set(user.toJson());
  }

  Future<AppUser> getUser(String id) async{
    DocumentSnapshot result = await  _users.doc(id).get();
    AppUser user = AppUser.fromJson(result.data());
    print("User fectched!: ${user.email}");
    return user;
  }

  void updateUser(String id, AppUser user) {
    _users.doc(id).update(user.toJson());
    print("${user.email}: User updated");
  }
}
