import 'package:flutter/material.dart';

class SimpleNumberInputForm extends StatefulWidget {
  final Function onPressed;
  final TextEditingController controller;
  final String buttonText;

  SimpleNumberInputForm({
    Key key,
    this.onPressed,
    this.controller,
    this.buttonText,
  }) : super(key: key);

  @override
  _SimpleNumberInputFormState createState() => _SimpleNumberInputFormState();
}


class _SimpleNumberInputFormState extends State<SimpleNumberInputForm> {

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 200,
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        RaisedButton(
          onPressed: widget.onPressed,
          child: Text(widget.buttonText),
        )
      ],
    );
  }
}
