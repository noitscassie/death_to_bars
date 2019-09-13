import 'package:flutter/material.dart';

import './../../../utils/authenticator.dart';

import './../../widgets/forms/simple_number_input_form.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with Authenticator {
  final TextEditingController phoneNumberInputController =
      TextEditingController();

  void _sendCodeOrSignIn(BuildContext context) {
    final String number = '+' + phoneNumberInputController.text;

    attemptPhoneAuthentication(context, number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SimpleNumberInputForm(
          onPressed: () {
            _sendCodeOrSignIn(context);
          },
          controller: phoneNumberInputController,
          buttonText: 'SIGN IN',
        ));
  }
}
