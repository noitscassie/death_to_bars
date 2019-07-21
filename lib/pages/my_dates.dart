import 'package:flutter/material.dart';
import './../models/user.dart';

class MyDatesPage extends StatelessWidget {
  final User user;

  MyDatesPage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('My Dates page');
  }
}
