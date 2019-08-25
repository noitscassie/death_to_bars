import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './profile_setup_page.dart';
import './../splash_screen.dart';
import './../../widgets/forms/simple_number_input_form.dart';
import './../../../models/user.dart';

import './../../../utils/authenticator.dart';
import './../../../utils/navigation_helper.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneNumberSignInPage extends StatefulWidget {
  @override
  _PhoneNumberSignInPageState createState() => _PhoneNumberSignInPageState();
}

class _PhoneNumberSignInPageState extends State<PhoneNumberSignInPage> with Authenticator, NavigationHelper {
  final phoneNumberInputController = TextEditingController();
  bool _buttonIsDisabled = false;
  bool loading = true;
  User user;

  Future<void> _sendCodeOrSignIn(BuildContext context) async {
    if (_buttonIsDisabled) {
      return;
    }

    final String number = '+' + phoneNumberInputController.text;
    attemptPhoneAuthentication(context, _auth, number);

    _disableButton();
  }

  void _handlePossibleRedirect(BuildContext context) async {
    FirebaseUser firebaseUser = await _auth.currentUser();

    if (firebaseUser == null || firebaseUser.phoneNumber == null) {
      setState(() {
        loading = false;
      });
      return;
    }

    User user = await User.findOrCreateFromPhoneNumber(firebaseUser.phoneNumber);

    if (user.name != null) {
      return navigateHomeAndClearHistory(context, user);
    }

    navigateTo(context, ProfileSetupPage(user: user));
  }


  void _disableButton() {
    setState(() {
      _buttonIsDisabled = true;
    });
  }

  @override

  initState() {
    super.initState();
    Timer(Duration(milliseconds: 700), () {
      _handlePossibleRedirect(context);
    });
  }

  void dispose() {
    phoneNumberInputController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (loading == true) {
      return SplashScreen();
    }

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
