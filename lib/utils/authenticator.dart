import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './../ui/pages/onboarding/sms_code_input_page.dart';
import './../ui/pages/onboarding/profile_setup_page.dart';

abstract class Authenticator {

  Future<void> attemptPhoneAuthentication(BuildContext context, FirebaseAuth auth, String number) async {

    final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential authCredential) async {
        print('Received phone auth credential: $authCredential');

        auth.signInWithCredential(authCredential);
        FirebaseUser firebaseUser = await auth.currentUser();
        Widget page = ProfileSetupPage(firebaseUser: firebaseUser);

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
          MaterialPageRoute(builder: (context) => SmsCodeInputPage(auth: auth, verificationId: verificationId))
        );
      };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
        // TODO: work out what to do here - for now just be noisy
        print('================================================================');
        print("time out");
        print('================================================================');
      };

    auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 30),
      codeSent: codeSent,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void authenticateWithSms(BuildContext context, FirebaseAuth auth, String verificationId, String smsCode) async {
    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await auth.signInWithCredential(credential);

    FirebaseUser firebaseUser = await auth.currentUser();

    if (firebaseUser != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileSetupPage(firebaseUser: firebaseUser))
      );
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page)
    );
  }
}
