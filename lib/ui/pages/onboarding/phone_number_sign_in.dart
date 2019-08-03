import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './profile_setup_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PhoneNumberSignInPage extends StatefulWidget {
  @override
  _PhoneNumberSignInPageState createState() => _PhoneNumberSignInPageState();
}

class _PhoneNumberSignInPageState extends State<PhoneNumberSignInPage> {
  final phoneNumberInputController = TextEditingController();
  final smsCodeInputController = TextEditingController();

  String _verificationId;
  bool _buttonIsDisabled = false;

  Future<void> _attemptPhoneAuthentication(BuildContext context) async {
    if (_buttonIsDisabled) {
      print('Button is disabled!');
      print(_verificationId);
      print(await _auth.currentUser());
      return null;
    }

    final String number = phoneNumberInputController.text;

    final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential authCredential) async {
         _auth.signInWithCredential(authCredential);
         print('Received phone auth credential: $authCredential');

        _maybeNavigateToProfileSetupPage(context);
      };

    final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
        // TODO: handle errors here
        print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      };

    final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
        _verificationId = verificationId;
        print("code sent to " + number);
      };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
        _verificationId = verificationId;
        print("time out");
      };

    _disableButton();

    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 5),
      codeSent: codeSent,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void _signInWithSms(BuildContext context) async {
    if (_verificationId == null) {
      return null;
    }

    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: smsCodeInputController.text,
    );

    await _auth.signInWithCredential(credential);

    _maybeNavigateToProfileSetupPage(context);
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

  void dispose() {
    phoneNumberInputController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kill the bars'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextField(
                  controller: phoneNumberInputController,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _attemptPhoneAuthentication(context);
                },
                child: Text('Send SMS'),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextField(
                  controller: smsCodeInputController,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _signInWithSms(context);
                },
                child: Text('Auth with code'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
