import 'package:death_to_bars/bloc/bloc_provider.dart';
import 'package:death_to_bars/bloc/user_bloc.dart';
import 'package:flutter/material.dart';

import './../../../utils/navigation_helper.dart';

class ProfileSetupPage extends StatefulWidget {
  @override
  _ProfileSetupPageState createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> with NavigationHelper {
  final nameInputController = TextEditingController();
  final bioInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserBloc _bloc;

  void _updateUserAndNavigateHome(BuildContext context) {
    _bloc.updateUser({
      'name': nameInputController.text,
      'bio': bioInputController.text,
    });
    navigateHomeAndClearHistory(context);
  }

  @override

  initState() {
    super.initState();
    _bloc = BlocProvider.of<UserBloc>(context);
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
