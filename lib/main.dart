import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/user_bloc.dart';
import 'ui/pages/onboarding/sign_in_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      bloc: UserBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SignInPage(),
      ),
    );
  }
}
