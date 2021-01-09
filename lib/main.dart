import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/controllers/cart_controller.dart';
import 'package:student_shop/ui/auth/register_screen.dart';
import 'package:student_shop/ui/screens/cart_screen.dart';
import 'package:student_shop/ui/screens/checkout.dart';
import 'package:student_shop/ui/screens/homepage.dart';

import 'controllers/auth_controller.dart';
import 'controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => UserController(), lazy: false,),
        ChangeNotifierProvider(create: (_) => AuthController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Shop',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Color(0xFFf9f9f9),
          accentColor: Color(0xFF2D2943),
          primaryIconTheme: IconThemeData(color: Colors.black),
          primaryTextTheme: TextTheme(caption: TextStyle(color: Colors.grey)),
          fontFamily: "Montserrat",
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => Homepage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/cart': (context) => CartScreen(),
          '/checkout': (context) => CheckoutScreen(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}
