import 'package:flutter/foundation.dart';
import 'package:student_shop/db/db.dart';
import 'package:student_shop/models/user_model.dart';

class UserController extends ChangeNotifier {
  AppUser _user = AppUser();

  UserController() {
    initUser();
  }

  initUser() async {
    _user = await FirestoreDB().getUser();
  }

  AppUser get user => _user;
  
  dynamic get printUser => _user.toJson();

  set setAddress(String address) {
    _user.address = address;
    print("address set");
    notifyListeners();
  }

  set setNumber(String number) {
    _user.phoneNo = number;
    notifyListeners();
  }

  void clearData() {
    _user = AppUser();
    notifyListeners();
  }
}
