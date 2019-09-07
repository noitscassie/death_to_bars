import 'package:flutter/material.dart';

import './../models/user.dart';
import './../ui/pages/home.dart';

mixin NavigationHelper {
  void navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page)
    );
  }

  void navigateToAndClearHistory(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false
    );
  }

  void navigateHomeAndClearHistory(BuildContext context, User user) {
    navigateToAndClearHistory(context, HomePage(user: user));
  }
}
