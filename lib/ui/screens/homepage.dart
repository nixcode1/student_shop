import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_shop/auth/auth_api.dart';
import 'package:student_shop/db/db.dart';
import 'package:student_shop/models/user_model.dart';
import 'package:student_shop/ui/auth/login_screen.dart';
import 'package:student_shop/ui/screens/home_screen.dart';
import 'package:student_shop/ui/widgets/cart_widget.dart';

class Homepage extends StatelessWidget {
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return LoginOrRegister();
        } else {
          return MyHomepage();
        }
      },
    );
  }
}

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
    double kHeight = MediaQuery.of(context).size.height;
    double kWidth = MediaQuery.of(context).size.width;
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
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                setState(() {
                  _body = HomeScreen();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                //
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // Auth().instance.signOut();
          String userID = Auth().instance.currentUser.uid;
          AppUser user = await FirestoreDB().getUser(userID)
          ..address = 'test'
          ..phoneNo = '09345389456'
          ..name = "Admin";
          FirestoreDB().updateUser(userID, user);
        },
      ),
      body: _body,
    );
  }
}
