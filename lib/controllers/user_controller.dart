import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:student_shop/db/db.dart';
import 'package:student_shop/models/user_model.dart';

class UserController extends ChangeNotifier {
  AppUser _user = AppUser();
  bool updateUser = false;

  UserController() {
    if(FirebaseAuth.instance.currentUser != null) {
      initUser();
    }
  }

  initUser() async {
    _user = await FirestoreDB().getUser();
  }

  AppUser get user => _user;

  dynamic get printUser => _user.toJson();

  set setAddress(String address) {
    _user.address = address;
    updateUser = true;
    print("address set");
    notifyListeners();
  }

  set setNumber(String number) {
    _user.phoneNo = number;
    updateUser = true;
    notifyListeners();
  }

  void clearUser() {
    _user = AppUser();
    notifyListeners();
  }
}
