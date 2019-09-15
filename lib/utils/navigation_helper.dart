import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  void navigateHomeAndClearHistory(BuildContext context, DocumentReference reference) {
    navigateToAndClearHistory(context, HomePage(reference: reference,));
  }
}
