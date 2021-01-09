import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_shop/ui/auth/login_screen.dart';
import 'package:student_shop/ui/auth/register_screen.dart';

class AuthController extends ChangeNotifier{
  Widget currentScreen = LoginScreen();

  void signUp(){
    currentScreen = RegisterScreen();
    notifyListeners();
  }

  void signIn() {
    currentScreen = LoginScreen();
    notifyListeners();
  }
}