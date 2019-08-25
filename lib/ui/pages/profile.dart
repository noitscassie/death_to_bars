import 'package:flutter/material.dart';

import './../../models/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({Key key, this.user}) : super(key: key);

  void _doFirebaseThing() async { }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('just want to see some text on the page'),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://www.some.ox.ac.uk/wp-content/uploads/2015/09/Peter.jpg'),
                    ),
                  ),
                ),
                Text('Name:'),
                Text(user.name),
                Text('Bio:'),
                Text(user.bio),
                RaisedButton(
                  onPressed: _doFirebaseThing,
                  child: Text('Do firebase thing'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
