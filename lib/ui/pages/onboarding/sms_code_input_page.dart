import 'package:flutter/material.dart';

import './../../widgets/forms/simple_number_input_form.dart';
import './../../../utils/authenticator.dart';

class SmsCodeInputPage extends StatefulWidget {
  final String verificationId;

  SmsCodeInputPage({Key key, this.verificationId}) : super(key: key);

  @override

  _SmsCodeInputPageState createState() => _SmsCodeInputPageState();
}

class _SmsCodeInputPageState extends State<SmsCodeInputPage> with Authenticator {
  final smsCodeInputController = TextEditingController();

  void _signInWithSms(BuildContext context) async {
    authenticateWithSms(context, widget.verificationId, smsCodeInputController.text);
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SimpleNumberInputForm(
        onPressed: () {
          _signInWithSms(context);
        },
        controller: smsCodeInputController,
        buttonText: 'auth',
      )
    );
  }
}
