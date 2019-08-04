import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './../../../models/user.dart';

class ProfileSetupPage extends StatefulWidget {
  final FirebaseUser firebaseUser;
  final Firestore firestore = Firestore.instance;

  ProfileSetupPage({Key key, this.firebaseUser}) : super(key: key);

  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {

  void _doThing() async {
    User user = await User.findOrCreateFromPhoneNumber(widget.firebaseUser.phoneNumber);
    print('============================================');
    print(user.phoneNumber);
    print('============================================');
  }

  @override

  initState() {
    // print(widget.firebaseUser.phoneNumber);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: RaisedButton(
          onPressed: _doThing,
          child: Text('get data'),
        ),
      ),
    );
  }
}
