import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user.dart';
import '../screens/events_screen.dart';
import '../screens/home_screen.dart';
import '../screens/school_information_screen.dart';
import '../cubit/user_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedMenuIndex = 1;
  late User user;

  @override
  void initState() {
    super.initState();
    user = (context.read<UserCubit>().state as UserLoaded).user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedMenuIndex, children: [
        const EventsScreen(),
        HomeScreen(
          onEventsClicked: () {
            setState(() {
              _selectedMenuIndex = 0;
            });
          },
          onCreateTeamClicked: user.level == "1" ? () => setState(() {
            _selectedMenuIndex = 2;
          }) : null,
        ),
        if (user.level == "1") const SchoolInformationScreen(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _selectedMenuIndex,
          onTap: (value) => setState(() {
                _selectedMenuIndex = value;
              }),
          items: [
            const BottomNavigationBarItem(label: "", icon: Icon(Icons.emoji_events)),
            const BottomNavigationBarItem(label: "", icon: Icon(Icons.home)),
            if(user.level == "1") const BottomNavigationBarItem(
                label: "", icon: Icon(Icons.account_circle)),
          ]),
    );
  }
}
