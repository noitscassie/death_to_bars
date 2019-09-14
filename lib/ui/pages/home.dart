import 'package:death_to_bars/bloc/bloc_provider.dart';
import 'package:death_to_bars/bloc/user_bloc.dart';
import 'package:death_to_bars/models/user.dart';
import 'package:flutter/material.dart';
import 'available_dates.dart';
import 'my_dates.dart';
import 'profile.dart';
import 'propose_date.dart';
import './../../utils/navigation_helper.dart';

class HomePage extends StatefulWidget {
  List<Widget> screens(User user) {
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

  void _navigateToProposeDate(BuildContext context, User user) {
    navigateTo(context, ProposeDatePage(user: user));
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<UserBloc>(context);
  }

  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: _bloc.userStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text('💀🍸💀🍸💀🍸💀🍸💀🍸💀'),
              automaticallyImplyLeading: false,
            ),
            body: widget.screens(user).elementAt(_selectedIndex),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _navigateToProposeDate(context, user);
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

        return Container();
      }
    );
  }
}
