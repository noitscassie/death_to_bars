import 'package:flutter/material.dart';
import './../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({Key key, this.user}) : super(key: key);

  void _doFirebaseThing() async {
    var snapshots = await Firestore.instance.collection('users').getDocuments();
    print('==========================');
    print(snapshots.documents[0].data);
    print('==========================');
    print(snapshots.documents[0].documentID);
    print('==========================');
    print(snapshots.documents[0].metadata);
    print('==========================');
  }

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
                      image: NetworkImage(user.imageUrl()),
                    ),
                  ),
                ),
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
