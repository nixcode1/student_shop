import 'package:flutter/material.dart';
import 'package:student_shop/auth/auth_api.dart';
import 'package:student_shop/ui/screens/drawer.dart';

import 'auth/login_or_register.dart';

class Home extends StatelessWidget {
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return LoginOrRegister();
        } else {
          return DrawerMenu();
        }
      },
    );
  }
}
