import 'package:flutter/material.dart';
import 'available_dates.dart';
import 'my_dates.dart';
import 'profile.dart';
import 'propose_date.dart';
import './../../models/user.dart';
import './../../utils/navigation_helper.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({Key key, this.user}) : super(key: key);

  List<Widget> screens() {
    return <Widget>[
      AvailableDatesPage(user: user),
      MyDatesPage(user: user),
      ProfilePage(user: user),
    ];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with NavigationHelper {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToProposeDate(BuildContext context) {
    navigateTo(context, ProposeDatePage(user: widget.user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('💀🍸💀🍸💀🍸💀🍸💀🍸💀'),
        automaticallyImplyLeading: false,
      ),
      body: widget.screens().elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToProposeDate(context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('Find a date'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            title: Text('My dates'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
    );
  }
}
