import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_shop/models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final String userID = FirebaseAuth.instance.currentUser.uid;

  MessageWidget({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Align(
        alignment: userID == message.user
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Card(
          child: Column(
            crossAxisAlignment: userID == message.user
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child:
                    userID == message.user ? Text(message.user) : Text("Admin"),
              ),
              Text(message.text)
            ],
          ),
        ),
      ),
    );
  }
}
