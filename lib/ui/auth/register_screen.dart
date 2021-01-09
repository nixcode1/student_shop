import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/auth/auth_api.dart';
import 'package:student_shop/controllers/auth_controller.dart';
import 'package:student_shop/controllers/user_controller.dart';
import 'package:student_shop/ui/widgets/button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final auth = Auth();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper2(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5d5778), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
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
                      "Create",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          _buildForm(context)
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.30,
      child: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(30),
          child: ListView(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _nameController,
                validator: (value) {
                  if (value.length < 6) {
                    return "That's quite a short name";
                  }
                },
                decoration: getInputDecor("Name"),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white),
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
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value.length < 6) {
                    return "Password must be at least 6 characters long";
                  }
                },
                controller: _passwordController,
                decoration: getInputDecor('Password'),
              ),
              SizedBox(
                height: 30,
              ),
              registerButton(),
              signInBtn(context)
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration getInputDecor(String text) {
    InputDecoration _inputDecoration = InputDecoration(
      
      labelText: text,
      labelStyle: TextStyle(color: Colors.white),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return _inputDecoration;
  }

  Widget registerButton() {
    return MainButton(
      title: "Register",
      onTap: () async {
        FocusManager.instance.primaryFocus.unfocus();
        if (_formKey.currentState.validate()) {
          _showMyDialog();
          String message = await auth.registerWithEmail(
              _emailController.text, _passwordController.text, _nameController.text);
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

  Widget signInBtn(BuildContext context) {
    return MainButton(
      title: "Sign in",
      onTap: () => Provider.of<AuthController>(context, listen: false).signIn(),
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
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 80, size.width / 2, size.height - 80);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 90, size.width, size.height - 160);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.40, size.height);
    path.quadraticBezierTo(size.width * (0.45), size.height - 120,
        size.width * 0.75, size.height - 170);
    path.quadraticBezierTo(
        size.width * (0.90), size.height - 190, size.width, size.height - 225);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
