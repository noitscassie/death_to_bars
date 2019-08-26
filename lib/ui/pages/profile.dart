import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import './../../models/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File file;
  User user;

  void _uploadPicture() async {
    File file = await FilePicker.getFile(type: FileType.IMAGE);
    user.updateProfilePicture(file);
  }

  @override
  initState() {
    user = widget.user;
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: user.stream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data.data;
          return Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(data['profileImageUrl']),
                          ),
                        ),
                      ),
                      Text('Name:'),
                      Text(data['name']),
                      Text('Bio:'),
                      Text(data['bio']),
                      RaisedButton(
                        onPressed: _uploadPicture,
                        child: Text('Upload profile picture'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return Center(
          child: Text('Loading...')
        );
      }
    );
  }
}
