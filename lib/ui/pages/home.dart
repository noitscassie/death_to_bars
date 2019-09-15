import 'package:death_to_bars/bloc/bloc_provider.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:death_to_bars/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'available_dates.dart';
import 'my_dates.dart';
import 'profile.dart';
import 'propose_date.dart';
import './../../utils/navigation_helper.dart';

class HomePage extends StatefulWidget {
  final DocumentReference reference;

  HomePage({Key key, @required this.reference})
      : assert(reference != null),
        super(key: key);

  List<Widget> screens() {
    return <Widget>[
      AvailableDatesPage(),
      MyDatesPage(),
      ProfilePage(),
    ];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with NavigationHelper {
  int _selectedIndex = 0;
  UserBloc _bloc;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToProposeDate(BuildContext context) {
    navigateTo(context, ProposeDatePage());
  }

  @override
  void initState() {
    super.initState();
    _bloc = UserBloc(reference: widget.reference);
  }

  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: _bloc,
        child: Scaffold(
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
        ));
  }
}
