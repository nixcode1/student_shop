import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/auth/auth_api.dart';
import 'package:student_shop/controllers/drawerController.dart';
import 'package:student_shop/controllers/user_controller.dart';
import 'package:student_shop/ui/screens/chat-screen.dart';
import 'package:student_shop/ui/screens/home_screen.dart';
import 'package:student_shop/ui/screens/orders_screen.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int _id;
  @override
  void initState() {
    _id = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Theme.of(context).accentColor, Colors.purple[100]])),
      child: Stack(
        children: [
          Positioned(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
                // Padding(
                //   padding: EdgeInsets.only(left: 70),
                //   child: Column(
                //     children: [
                //       CircleAvatar(
                //         backgroundColor: Colors.white,
                //         radius: 40,
                //         child: GetBuilder<User>(
                //           builder: (_) {
                //             return Text(
                //               _.username[0].capitalizeFirst ?? "",
                //               style: TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 40,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                _drawerMenuItem(id: 0, title: "Home", icon: Icons.home),
                _drawerMenuItem(id: 1, title: "Orders", icon: Icons.person),
                _drawerMenuItem(
                    id: 2, title: "Chat", icon: Icons.message_outlined),
                _drawerMenuItem(
                    id: 3, title: "Wish List", icon: Icons.star_outline),
                SizedBox(height: size.height * 0.3),
                GestureDetector(
                  onTap: () => {},
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 100),
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app, color: Colors.white),
                      title: Text(
                        'Log out',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        Auth().instance.signOut();
                        Provider.of<UserController>(context, listen: false)
                            .clearUser();
                        context.read<CustomDrawerController>().closeDrawer();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            transform: Matrix4.translationValues(
                context.watch<CustomDrawerController>().xOffset,
                context.watch<CustomDrawerController>().yOffset,
                0)
              ..scale(context.watch<CustomDrawerController>().scaleFactor),
            duration: Duration(milliseconds: 600),
            child: ClipRRect(
              borderRadius: context.watch<CustomDrawerController>().isDrawerOpen
                  ? BorderRadius.circular(20)
                  : BorderRadius.circular(0),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (context.read<CustomDrawerController>().isDrawerOpen) {
                    context.read<CustomDrawerController>().closeDrawer();
                  }
                },
                onHorizontalDragStart: (_) {
                  if (_.localPosition.dx > size.width / 2) {
                    print("right swipe");
                  } else {
                    print("left swipe");
                    context.read<CustomDrawerController>().openDrawer(size);
                  }
                  print(_.localPosition);
                },
                child: IgnorePointer(
                  ignoring: context.read<CustomDrawerController>().isDrawerOpen,
                  child: IndexedStack(
                    index: _id,
                    children: [
                      HomeScreen(),
                      OrderScreen(),
                      ChatScreen(),
                      ChatScreen()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  /// Defines the drawer menu items(Drawer Menu)
  /// It makes sure the selected menu is highlighted when tapped
  ///
  /// [id] corresponds with the index of the screen in the indexStack
  Widget _drawerMenuItem({int id, String title, IconData icon}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _id = id;
          context.read<CustomDrawerController>().closeDrawer();
        });
      },
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.45,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: _id == id ? Colors.white : null,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
          ),
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(
                icon,
                color: _id == id ? Theme.of(context).accentColor : Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                    color: _id == id
                        ? Theme.of(context).accentColor
                        : Colors.white,
                    fontSize: 18),
              ),
            ],
          )),
    );
  }
}
