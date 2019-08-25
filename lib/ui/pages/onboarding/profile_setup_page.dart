import 'package:flutter/material.dart';

import './../../../models/user.dart';
import './../../../utils/navigation_helper.dart';

class ProfileSetupPage extends StatefulWidget {
  final User user;

  ProfileSetupPage({Key key, this.user}) : super(key: key);

  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> with NavigationHelper {
  final nameInputController = TextEditingController();
  final bioInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _updateUserAndNavigateHome(BuildContext context) async {
    await widget.user.update(
      {
        'name': nameInputController.text,
        'bio': bioInputController.text,
      }
    );
    navigateHomeAndClearHistory(context, widget.user);
  }

  @override

  initState() {
    super.initState();
  }

  void dispose() {
    nameInputController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child:
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: nameInputController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Name:',
                      helperText: 'What would you like people to call you?',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40),
                  ),
                  TextFormField(
                    controller: bioInputController,
                    maxLines: 5,
                    minLines: 5,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      icon: Icon(Icons.format_quote),
                      labelText: 'Bio:',
                      helperText: 'Tell people something about yourself',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: RaisedButton(
                      onPressed: () {
                        _updateUserAndNavigateHome(context);
                      },
                      child: Text('Do the thing'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
