import 'package:flutter/material.dart';

import './../models/user.dart';
import './../ui/pages/home.dart';

mixin NavigationHelper {
  void navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page)
    );
  }

  void navigateHomeAndClearHistory(BuildContext context, User user) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomePage(user: user)),
      (Route<dynamic> route) => false
    );
  }
}
