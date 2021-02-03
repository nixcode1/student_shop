import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/controllers/drawerController.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: ElevatedButton(
          child: Text("Drawer"),
          onPressed: () => context
              .read<CustomDrawerController>()
              .openDrawer(MediaQuery.of(context).size),
        ),
      ),
    ));
  }
}
