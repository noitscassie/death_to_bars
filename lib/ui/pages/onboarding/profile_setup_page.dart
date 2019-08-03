import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileSetupPage extends StatelessWidget {
  final FirebaseUser firebaseUser;

  ProfileSetupPage({Key key, this.firebaseUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kill the bars'),
      ),
      body: Center(child: Text('fuck bars')),
    );
  }
}
