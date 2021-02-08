import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/controllers/drawerController.dart';
import 'package:student_shop/ui/widgets/cart_widget.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("TechPlug", style: TextStyle(fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: context.watch<CustomDrawerController>().isDrawerOpen
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 25),
                onPressed: () =>
                    context.read<CustomDrawerController>().closeDrawer(),
              )
            : IconButton(
                icon: Icon(Icons.filter_list, size: 30),
                onPressed: () =>
                    context.read<CustomDrawerController>().openDrawer(size),
              ),
        actions: [CartWidget()],
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text("order"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
