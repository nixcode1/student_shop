import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/auth/auth_api.dart';
import 'package:student_shop/controllers/drawerController.dart';
import 'package:student_shop/controllers/user_controller.dart';
import 'package:student_shop/ui/screens/home_screen.dart';
import 'package:student_shop/ui/test.dart';
import 'package:student_shop/ui/widgets/cart_widget.dart';

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _body = HomeScreen();

  List<String> list = [
    "All",
    "Laptops",
    "Laptop accessories",
    "Laptop Bags",
    "Just saying",
    "bla bla",
    "kil bil",
  ];

  TextStyle headingStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("TechPlug", style: TextStyle(fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.filter_list, size: 30), onPressed: _openDrawer),
        actions: [CartWidget()],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).accentColor,
              ),
              title: Text('Home'),
              onTap: () {
                setState(() {
                  _body = HomeScreen();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart,
                  color: Theme.of(context).accentColor),
              title: Text('Orders'),
              onTap: () {
                //
                setState(() {
                  _body = Sliver();
                });
                Navigator.pop(context);
              },
            ),
            Spacer(),
            ListTile(
              leading:
                  Icon(Icons.exit_to_app, color: Theme.of(context).accentColor),
              title: Text('Log out'),
              onTap: () {
                Auth().instance.signOut();
                Provider.of<UserController>(context, listen: false).clearUser();
              },
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              // Auth().instance.signOut();
              // String userID = Auth().instance.currentUser.uid;
              // AppUser user = await FirestoreDB().getUser(userID)
              // ..address = 'test'
              // ..phoneNo = '09345389456'
              // ..name = "Admin";
              // FirestoreDB().updateUser(userID, user);
              // dynamic user =
              //     Provider.of<UserController>(context, listen: false).printUser;
              // print(user);
              // FirestoreDB().fetchOrders();
              context
                  .read<CustomDrawerController>()
                  .openDrawer(MediaQuery.of(context).size);
            },
          ),
        ],
      ),
      body: _body,
    );
  }
}
