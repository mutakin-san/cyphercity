import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/events_screen.dart';
import '../screens/home_screen.dart';
import '../screens/school_information_screen.dart';
import '../bloc/bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedMenuIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, bool>(
      selector: (state) {
        return state is UserAuthenticated && state.user.level == "1";
      },
      builder: (context, isSchoolAccount) {
        return Scaffold(
          body: IndexedStack(index: _selectedMenuIndex, children: [
            const EventsScreen(),
            HomeScreen(
              onEventsClicked: () {
                setState(() {
                  _selectedMenuIndex = 0;
                });
              },
              onCreateTeamClicked: isSchoolAccount
                  ? () {
                    setState(() {
                      _selectedMenuIndex = 2;
                    });
                  }
                  : null,
            ),
            if(isSchoolAccount) const SchoolInformationScreen(),
          ]),
          bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              showSelectedLabels: false,
              currentIndex: _selectedMenuIndex,
              onTap: (value) => setState(() {
                    _selectedMenuIndex = value;
                  }),
              items: [
                const BottomNavigationBarItem(
                    label: "", icon: Icon(Icons.emoji_events)),
                const BottomNavigationBarItem(
                    label: "", icon: Icon(Icons.home)),
                if (isSchoolAccount)
                  const BottomNavigationBarItem(
                      label: "", icon: Icon(Icons.account_circle)),
              ]),
        );
      },
    );
  }
}
