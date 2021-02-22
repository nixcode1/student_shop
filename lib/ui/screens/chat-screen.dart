import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shop/controllers/drawerController.dart';
import 'package:student_shop/db/db.dart';
import 'package:student_shop/models/message.dart';

import '../widgets/message_widget.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _db = FirestoreDB();
  final userID = FirebaseAuth.instance.currentUser.uid;
  TextEditingController _messageController;

  @override
  void initState() {
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(fontWeight: FontWeight.bold)),
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
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  context.read<CustomDrawerController>().openDrawer(size);
                },
              ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: _db.getMessage(userID),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data.docs
                              .map((e) => MessageWidget(
                                    message: Message.fromJson(e.data()),
                                  ))
                              .toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              _buildFooter(context)
            ],
          )),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: getInputDecor("Enter message..."),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: sendMessage,
            child: Text("Send"),
          ),
        ],
      ),
    );
  }

  InputDecoration getInputDecor(String text) {
    InputDecoration _inputDecoration = InputDecoration(
        hintText: text,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)));
    return _inputDecoration;
  }

  void sendMessage() {
    _db.addMessage(Message(userID, _messageController.text).toJson(),
        FirebaseAuth.instance.currentUser.uid);
    _messageController.clear();
  }
}
