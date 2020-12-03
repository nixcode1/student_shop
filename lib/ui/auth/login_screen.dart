import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/auth/auth_api.dart';
import 'package:student_shop/controllers/user_controller.dart';

class LoginOrRegister extends StatefulWidget {
  @override
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
              ),
              registerButton(),
              loginButton(),
              googleButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return RaisedButton(
      onPressed: () async {
        _showMyDialog();
        String message = await auth.registerWithEmail(
            _emailController.text, _passwordController.text);
            Navigator.pop(context);
        _scaffoldKey.currentState.showSnackBar(mySnackBar(message));
        if(message == "Signed In") {
          await Provider.of<UserController>(context, listen: false).initUser();
        }
      },
      child: Text("Register"),
    );
  }

  Widget loginButton() {
    return RaisedButton(
      onPressed: () async {
        _showMyDialog();
        String message = await auth.signInWithEmail(
            _emailController.text, _passwordController.text);
            Navigator.pop(context);
        _scaffoldKey.currentState.showSnackBar(mySnackBar(message));
        if(message == "Signed In") {
          await Provider.of<UserController>(context, listen: false).initUser();
        }
      },
      child: Text("Login"),
    );
  }

  Widget googleButton() {
    return RaisedButton(
      onPressed: () async {
        String message = await auth.signInWithGoogle();
        if(message == "Signed In") {
          await Provider.of<UserController>(context, listen: false).initUser();
        }
      },
      child: Text("Google"),
    );
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(child: Text('Loading')),
          children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          )],
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
