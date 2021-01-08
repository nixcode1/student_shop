import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const MainButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: onTap,
        child: Container(
          height: size.height * 0.075,
          width: size.width,
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [Color(0xFF5d5778), Color(0xFF2d2942)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 16,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }
}
