import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(
              Icons.favorite,
              size: 150,
              color: Colors.white,
            ),
          ),
          Center(
            child: Text(
              'ditch the bars',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Parisienne',
                fontSize: 50,
              ),
            )
          )
        ],
      )
    );
  }
}
