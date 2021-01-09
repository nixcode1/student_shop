import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/auth/auth_api.dart';
import 'package:student_shop/controllers/auth_controller.dart';
import 'package:student_shop/controllers/user_controller.dart';
import 'package:student_shop/ui/auth/register_screen.dart';
import 'package:student_shop/ui/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_formKay');
  final _scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_homeScreenkey');
  final auth = Auth();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 320),
              decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [Color(0xFF5d5778), Colors.white],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value.length < 10) {
                            return "Enter a valid email";
                          }
                        },
                        decoration: getInputDecor("Email"),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                        },
                        controller: _passwordController,
                        decoration: getInputDecor('Password'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      loginButton(),
                      registerButton(context),
                      SizedBox(
                        height: 20,
                      ),
                      googleButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              width: size.width,
              height: size.height / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5d5778), Color(0xFF2d2942)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Back",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return MainButton(
      title: "Sign up",
      onTap: () => Provider.of<AuthController>(context, listen: false).signUp(),
    );
  }

  Widget loginButton() {
    return MainButton(
      title: "Login",
      onTap: () async {
        FocusManager.instance.primaryFocus.unfocus();
        if (_formKey.currentState.validate()) {
          _showMyDialog();
          String message = await auth.signInWithEmail(
              _emailController.text, _passwordController.text);
          Navigator.pop(context);
          _scaffoldKey.currentState.showSnackBar(mySnackBar(message));
          if (message == "Signed In") {
            await Provider.of<UserController>(context, listen: false)
                .initUser();
          }
        }
      },
    );
  }

  Widget googleButton() {
    return GoogleAuthButton(
      onPressed: () async {
        String message = await auth.signInWithGoogle();
        if (message == "Signed In") {
          await Provider.of<UserController>(context, listen: false).initUser();
        }
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(child: Text('Loading')),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            )
          ],
        );
      },
    );
  }

  Widget mySnackBar(String message) {
    return SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  InputDecoration getInputDecor(String text) {
    InputDecoration _inputDecoration = InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Color(0xFF2D2943)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF2D2943)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return _inputDecoration;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(
        size.width * 0.5, size.height, size.width * 0.58, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.5,
        size.width * 0.75, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.95, size.height * 0.3, size.width, size.height * 0.2);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
