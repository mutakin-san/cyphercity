import 'package:cyphercity/screens/competition_screen.dart';
import 'package:cyphercity/screens/home_screen.dart';
import 'package:cyphercity/screens/team_information_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedMenuIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedMenuIndex, children: [
        const CompetitionScreen(),
        HomeScreen(
          onCreateTeamClicked: () => setState(() {
            _selectedMenuIndex = 2;
          }),
        ),
        const TeamInformationScreen(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _selectedMenuIndex,
          onTap: (value) => setState(() {
                _selectedMenuIndex = value;
              }),
          items: const [
            BottomNavigationBarItem(label: "", icon: Icon(Icons.people)),
            BottomNavigationBarItem(label: "", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "", icon: Icon(Icons.account_circle)),
          ]),
    );
  }
}
