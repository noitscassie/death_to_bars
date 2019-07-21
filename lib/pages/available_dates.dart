import 'package:flutter/material.dart';
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
          children: <Widget> [
            Text('Now signed in on this page!')
          ],
        ),
      ),
    );
  }
}
