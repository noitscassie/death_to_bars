import 'package:flutter/material.dart';

mixin NavigationHelper {
  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page)
    );
  }
}
