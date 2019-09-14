import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './../ui/pages/onboarding/sms_code_input_page.dart';
import './../ui/pages/onboarding/profile_setup_page.dart';
import './../ui/pages/home.dart';
import './../models/user.dart';

mixin Authenticator {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> attemptPhoneAuthentication(BuildContext context, String number) async {

    final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential authCredential) async {
        print('Received phone auth credential: $authCredential');

        await _auth.signInWithCredential(authCredential);
        FirebaseUser firebaseUser = await _auth.currentUser();
        User user = await _userFromPhoneNumber(firebaseUser.phoneNumber);

        Widget page = user.completedSignUp ? HomePage() : ProfileSetupPage();

        _navigateTo(context, page);
       };

    final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
        // TODO: handle errors here
        print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      };

    final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
        print("code sent to " + number);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SmsCodeInputPage(verificationId: verificationId))
        );
      };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
        // TODO: work out what to do here - for now just be noisy
        print('================================================================');
        print("time out");
        print('================================================================');
      };

    _auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 30),
      codeSent: codeSent,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void authenticateWithSms(BuildContext context, String verificationId, String smsCode) async {
    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await _auth.signInWithCredential(credential);

    FirebaseUser firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      User user = await _userFromPhoneNumber(firebaseUser.phoneNumber);

      Widget page = user.completedSignUp ? HomePage() : ProfileSetupPage();

      _navigateTo(context, page);
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false
    );
  }

  Future<User> _userFromPhoneNumber(String phoneNumber) async {
    DocumentReference reference = await User.findFromPhoneNumber(phoneNumber);
    DocumentSnapshot snapshot = await reference.get();

    return User.fromDocumentSnapshot(snapshot);
  }
}
