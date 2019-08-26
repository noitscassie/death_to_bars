import 'package:flutter/material.dart';

import 'ui/pages/onboarding/phone_number_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: PhoneNumberSignInPage(),
    );
  }
}
