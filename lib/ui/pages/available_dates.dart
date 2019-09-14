import 'package:flutter/material.dart';

import 'package:death_to_bars/bloc/bloc_provider.dart';
import 'package:death_to_bars/bloc/user_bloc.dart';

import './../widgets/date_card.dart';
import './../../models/user.dart';

class AvailableDatesPage extends StatefulWidget {
  @override
  _AvailableDatesPageState createState() => _AvailableDatesPageState();
}

class _AvailableDatesPageState extends State <AvailableDatesPage> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: _userBloc.userStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget> [
                DateCard(
                    user: user,
                    description: 'Go bowling!',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'See the Leonardo da Vinci exhibit',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'Hang out in a park',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'Go to a bar 💀💀💀💀',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'grab some dinner',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'Go swimming in a lake',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'Wander around battersea park',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'Go to the cinema',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'Build a tree house',
                    time: DateTime.now().add(Duration(days: 3))
                ),
                DateCard(
                    user: user,
                    description: 'Go on a bike ride in Richmond',
                    time: DateTime.now().add(Duration(days: 3))
                ),
              ],
            ),
          );
        }

        return Center(
            child: Text('Loading...')
        );
      }
    );
  }
}
