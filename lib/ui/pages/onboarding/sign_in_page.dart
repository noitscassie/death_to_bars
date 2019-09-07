import 'package:flutter/material.dart';

import './../../../bloc/bloc_provider.dart';
import './../../../bloc/user_bloc.dart';
import './../../../models/user.dart';

import './../../../utils/authenticator.dart';

import './../splash_screen.dart';
import './profile_setup_page.dart';
import './../home.dart';

import './../../widgets/forms/simple_number_input_form.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with Authenticator {
  final TextEditingController phoneNumberInputController =
      TextEditingController();

  UserBloc _bloc;

  void _sendCodeOrSignIn(BuildContext context) {
    final String number = '+' + phoneNumberInputController.text;

    attemptPhoneAuthentication(context, number);
  }

  @override

  void initState() {
    _bloc = BlocProvider.of<UserBloc>(context);
    _bloc.getFromPhoneNumber();
    super.initState();
  }
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.userStream,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }

          if (snapshot.hasData && snapshot.data.completedSignUp) {
            return HomePage(user: snapshot.data);
          }

          if (snapshot.hasData && !snapshot.data.completedSignUp) {
            return ProfileSetupPage(user: snapshot.data);
          }

//          todo: extract this out to its own file

          return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              body: SimpleNumberInputForm(
                onPressed: () {
                  _sendCodeOrSignIn(context);
                },
                controller: phoneNumberInputController,
                buttonText: 'SIGN IN',
              ));
        });
  }
}
