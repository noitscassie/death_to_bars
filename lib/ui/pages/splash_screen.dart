import 'package:death_to_bars/ui/pages/onboarding/sign_in_page.dart';
import 'package:death_to_bars/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import './../../models/user.dart';

import './../../utils/navigation_helper.dart';
import 'onboarding/profile_setup_page.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NavigationHelper {
  void _fetchUserAndRedirect() async {
    String phoneNumber;
    DocumentReference reference = await User.findFromPhoneNumber(phoneNumber);

    if (reference == null) {
      navigateTo(context, SignInPage());
    }

    User _user = User.fromDocumentSnapshot(await reference.get());

    if (_user.completedSignUp) {
      navigateHomeAndClearHistory(context, reference);
    }

    navigateToAndClearHistory(context, ProfileSetupPage(reference: reference));
  }

  @override
  void initState() {
    super.initState();
    _fetchUserAndRedirect();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(
              Icons.favorite,
              size: 150,
              color: Colors.white,
            ),
          ),
          Center(
            child: Text(
              'ditch the bars',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Parisienne',
                fontSize: 50,
              ),
            )
          )
        ],
      )
    );
  }
}
