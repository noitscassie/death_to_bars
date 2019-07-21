import 'package:flutter/material.dart';
import './../models/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Profile page');
  }
}
