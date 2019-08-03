import 'package:flutter/material.dart';
import './../widgets/date_card.dart';
import './../../models/user.dart';

class AvailableDatesPage extends StatefulWidget {
  final User user;

  const AvailableDatesPage({Key key, this.user}): super(key: key);

  @override
  _AvailableDatesPageState createState() => _AvailableDatesPageState();
}

class _AvailableDatesPageState extends State <AvailableDatesPage> {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: <Widget> [
          DateCard(
            user: widget.user,
            description: 'Go bowling!',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'See the Leonardo da Vinci exhibit',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'Hang out in a park',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'Go to a bar 💀💀💀💀',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'grab some dinner',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'Go swimming in a lake',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'Wander around battersea park',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'Go to the cinema',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'Build a tree house',
            time: DateTime.now().add(Duration(days: 3))
          ),
          DateCard(
            user: widget.user,
            description: 'Go on a bike ride in Richmond',
            time: DateTime.now().add(Duration(days: 3))
          ),
        ],
      ),
    );
  }
}
