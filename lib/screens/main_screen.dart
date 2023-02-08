import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../models/user.dart';
import '../screens/events_screen.dart';
import '../screens/home_screen.dart';
import '../screens/school_information_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedMenuIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, User?>(
      selector: (state) {
        return state is UserAuthenticated ? state.user : null;
      },
      builder: (context, user) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => _refreshBloc(user?.userId),
            child: IndexedStack(index: _selectedMenuIndex, children: [
              const EventsScreen(),
              HomeScreen(
                onEventsClicked: () {
                  setState(() {
                    _selectedMenuIndex = 0;
                  });
                },
                onCreateTeamClicked: user?.level == "1"
                    ? () {
                        setState(() {
                          _selectedMenuIndex = 2;
                        });
                      }
                    : null,
              ),
              if (user?.level == "1") const SchoolInformationScreen(),
            ]),
          ),
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
                if (user?.level == "1")
                  const BottomNavigationBarItem(
                      label: "", icon: Icon(Icons.account_circle)),
              ]),
        );
      },
    );
  }

  Future<void> _refreshBloc(String? userId) async {
    if (userId != null) {
      context.read<SchoolBloc>().add(LoadSchool(userId));
    } else {
      context.read<UserBloc>().add(LoadUser());
    }

    await Future.delayed(const Duration(seconds: 1));
  }
}
