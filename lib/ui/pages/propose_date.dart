import 'package:flutter/material.dart';
import './../../models/user.dart';
import './../../models/date.dart';

class ProposeDatePage extends StatelessWidget {
  final User user;

  ProposeDatePage({Key key, this.user}) : super(key: key);

  Widget build(BuildContext context) {
    return Text('here is some text');
  }

  // await Date.create({
  //   'proposerId': widget.user.id,
  //   'description': 'Try the mountain bike track in Brockwell park'
  // });
}
