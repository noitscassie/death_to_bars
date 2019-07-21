import 'package:flutter/material.dart';
import 'available_dates.dart';
import './../models/user.dart';


class SignInPage extends StatelessWidget {
  final User _user = User();

  void _signInAndRedirect(BuildContext context) async {
    await _user.signIn();
    if (_user.signedIn()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AvailableDatesPage(user: _user))
      );
    }
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
