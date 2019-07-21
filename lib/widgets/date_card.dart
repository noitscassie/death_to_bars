import 'package:flutter/material.dart';
import './../models/user.dart';

class DateCard extends StatelessWidget {
  final User user;
  final String description;
  final DateTime time;

  const DateCard({Key key, this.user, this.description, this.time}): super(key: key);

  @override
  build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget> [
          SizedBox(
            height: 100,
            width: 100,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      user.imageUrl(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: SizedBox(
              height: 100,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Text> [
                  Text("${this.user.firstName()} wants to... go to the Leonardo Da Vinci Exhibition!"),
                  Text(''),
                  Text('Next Tuesday evening'),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: null,
          ),
        ],
      )
    );
  }
}
