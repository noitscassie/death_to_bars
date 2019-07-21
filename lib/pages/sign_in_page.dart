import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]
  );

  void _signInAndRedirect(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    // todo: redirect
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in screen')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            RaisedButton(
              onPressed: () {
                _signInAndRedirect(context);
              },
              child: Text('Sign in with Google')
            ),
          ],
        ),
      ),
    );
  }
}
