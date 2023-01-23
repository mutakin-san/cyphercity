import 'package:cyphercity/screens/add_team_screen.dart';
import 'package:flutter/material.dart';

class Team {
  final String name;
  final TeamType type;
  final Widget logo;

  const Team({required this.name, required this.type, required this.logo});
}

final dummyTeamPA = List.generate(5, (index) {
  return Team(
    name: "Team\n$index",
    type: TeamType.Man,
    logo: const Icon(Icons.sports_soccer, size: 45, color: Colors.black),
  );
});

final dummyTeamPI = List.generate(5, (index) {
  return Team(
    name: "Team\n$index",
    type: TeamType.Woman,
    logo: const Icon(Icons.sports_soccer, size: 45, color: Colors.pink),
  );
});
