import 'package:cyphercity/screens/information_screen.dart';
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
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Yakin ingin keluar?"),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SimpleDialogOption(
                      child: const Text("Ya"),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    ),
                    SimpleDialogOption(
                      child: const Text("Tidak"),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    )
                  ],
                )
              ],
            );
          },
        );
      },
      child: BlocSelector<UserBloc, UserState, User?>(
        selector: (state) {
          return state is UserAuthenticated ? state.user : null;
        },
        builder: (context, user) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () => _refreshBloc(user?.userId),
              child: IndexedStack(index: _selectedMenuIndex, children: [
                (user?.level != "0")
                    ? const EventsScreen()
                    : const InformationScreen(isShowBackButton: false),
                HomeScreen(
                  onCreateTeamClicked: user?.level != "0"
                      ? () {
                          setState(() {
                            _selectedMenuIndex = 2;
                          });
                        }
                      : null,
                ),
                if (user?.level != "0") const SchoolInformationScreen(),
              ]),
            ),
            bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: false,
                showSelectedLabels: false,
                currentIndex: _selectedMenuIndex,
                onTap: (value) {
                  setState(() {
                    _selectedMenuIndex = value;
                  });
                },
                items: [
                  (user?.level != "0")
                      ? const BottomNavigationBarItem(
                          label: "", icon: Icon(Icons.emoji_events))
                      : const BottomNavigationBarItem(
                          label: "", icon: Icon(Icons.info)),
                  const BottomNavigationBarItem(
                      label: "", icon: Icon(Icons.home)),
                  if (user?.level != "0")
                    const BottomNavigationBarItem(
                        label: "", icon: Icon(Icons.account_circle)),
                ]),
          );
        },
      ),
    );
  }

  Future<void> _refreshBloc(String? userId) async {
    if (userId != null) {
      context.read<SchoolBloc>().add(LoadSchool(userId));
      context.read<EventBloc>().add(GetAllEvent(userId));
    } else {
      context.read<UserBloc>().add(LoadUser());
    }

    await Future.delayed(const Duration(seconds: 1));
  }
}
