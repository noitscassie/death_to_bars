import 'dart:io';

import 'package:death_to_bars/bloc/bloc_provider.dart';
import 'package:death_to_bars/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import './../../models/user.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File file;
  UserBloc _bloc;

  void _uploadPicture() async {
    File file = await FilePicker.getFile(type: FileType.IMAGE);
    _bloc.setProfilePicture(file);
  }

  @override
  initState() {
    super.initState();
    _bloc = BlocProvider.of<UserBloc>(context);
  }

  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: _bloc.userStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

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
                            image: NetworkImage(user.image),
                          ),
                        ),
                      ),
                      Text('Name:'),
                      Text(user.name),
                      Text('Bio:'),
                      Text(user.bio),
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
