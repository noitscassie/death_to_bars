import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './profile_setup_page.dart';
import './../../widgets/forms/simple_number_input_form.dart';
import './../../../utils/authenticator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneNumberSignInPage extends StatefulWidget {
  @override
  _PhoneNumberSignInPageState createState() => _PhoneNumberSignInPageState();
}

class _PhoneNumberSignInPageState extends State<PhoneNumberSignInPage> with Authenticator {
  final phoneNumberInputController = TextEditingController();
  bool _buttonIsDisabled = false;

  Future<void> _sendCodeOrSignIn(BuildContext context) async {
    if (_buttonIsDisabled) {
      print('Button is disabled!');
      return null;
    }

    final String number = '+' + phoneNumberInputController.text;
    attemptPhoneAuthentication(context, _auth, number);

    _disableButton();
  }

  void _maybeNavigateToProfileSetupPage(BuildContext context) async {
    FirebaseUser firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileSetupPage(firebaseUser: firebaseUser))
      );
    }
  }

  void _disableButton() {
    setState(() {
      _buttonIsDisabled = true;
    });
  }

  @override

  initState() {
    super.initState();
    _maybeNavigateToProfileSetupPage(context);
  }

  void dispose() {
    phoneNumberInputController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SimpleNumberInputForm(
        onPressed: () {
          _sendCodeOrSignIn(context);
        },
        controller: phoneNumberInputController,
        buttonText: 'Send SMS',
      ),
    );
  }
}
