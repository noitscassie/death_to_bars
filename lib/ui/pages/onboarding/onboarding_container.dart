import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:death_to_bars/bloc/bloc_provider.dart';
import 'package:death_to_bars/bloc/user_bloc.dart';
import 'package:death_to_bars/models/user.dart';
import 'package:death_to_bars/ui/pages/home.dart';
import 'package:death_to_bars/ui/pages/onboarding/profile_setup_page.dart';
import 'package:death_to_bars/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class OnboardingContainer extends StatefulWidget {
  final DocumentReference reference;

  OnboardingContainer({Key key, this.reference}) : super(key: key);

  @override
  _OnboardingContainerState createState() => _OnboardingContainerState();
}

class _OnboardingContainerState extends State<OnboardingContainer> with NavigationHelper {
  UserBloc _bloc;
  Widget _child;

  void _listen() {
    _bloc = UserBloc(reference: widget.reference);
    _bloc.userStream.listen((User user) {
      if (user.completedSignUp) {
        _child = HomePage();
      }

      _child = ProfileSetupPage();
    });
  }

  @override
  void initState() {
    super.initState();
    _listen();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: _bloc,
        child: _child
    );
  }
}
