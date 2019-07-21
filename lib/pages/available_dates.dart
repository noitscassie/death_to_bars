import 'package:flutter/material.dart';
import './../widgets/date_card.dart';
import './../models/user.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Dates')
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: <Widget> [
            DateCard(
              user: widget.user,
              description: 'Some random description',
              time: DateTime.now().add(Duration(days: 3))
            )
          ],
        ),
      ),
    );
  }
}
