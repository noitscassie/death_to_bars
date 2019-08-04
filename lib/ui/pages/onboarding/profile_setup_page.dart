import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './../home.dart';
import './../../../models/user.dart';

class ProfileSetupPage extends StatefulWidget {
  final FirebaseUser firebaseUser;
  final Firestore firestore = Firestore.instance;

  ProfileSetupPage({Key key, this.firebaseUser}) : super(key: key);

  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final nameInputController = TextEditingController();
  final bioInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _updateUserAndNavigateHome(BuildContext context) async {
    User user = await User.findOrCreateFromPhoneNumber(widget.firebaseUser.phoneNumber);
    await user.update(
      {
        'name': nameInputController.text,
        'bio': bioInputController.text,
      }
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(user: user))
    );
  }

  @override

  initState() {
    User.findOrCreateFromPhoneNumber(widget.firebaseUser.phoneNumber);
    super.initState();
  }

  void disponse() {
    nameInputController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child:
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: nameInputController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Name:',
                      helperText: 'What would you like people to call you?',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40),
                  ),
                  TextFormField(
                    controller: bioInputController,
                    maxLines: 5,
                    minLines: 5,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      icon: Icon(Icons.format_quote),
                      labelText: 'Bio:',
                      helperText: 'Tell people something about yourself',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: RaisedButton(
                      onPressed: () {
                        _updateUserAndNavigateHome(context);
                      },
                      child: Text('Do the thing'),
                    ),
                  ),
                ],
              ), 
            ),
          ),
        ),
      ),
    );
  }
}
