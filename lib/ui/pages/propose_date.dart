import 'package:flutter/material.dart';
//import './../../models/date.dart';

class ProposeDatePage extends StatefulWidget {
  // Widget build(BuildContext context) {
  //   return Text('here is some text');
  // }

  // await Date.create({
  //   'proposerId': widget.user.id,
  //   'description': 'Try the mountain bike track in Brockwell park'
  // });

  @override
  _ProposeDatePageState createState() => _ProposeDatePageState();
}

class _ProposeDatePageState extends State<ProposeDatePage> {
  final _dateSuggestionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Center(
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _dateSuggestionController,
                decoration: InputDecoration(
                  icon: Icon(Icons.beach_access),
                  labelText: 'I want to...',
                  helperText: 'This is it. Your time to shine. Go wild.',
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
