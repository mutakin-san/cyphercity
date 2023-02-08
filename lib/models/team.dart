import 'package:flutter/material.dart';

import '../screens/add_team_screen.dart';

class Team {
  final String id;
  final String name;
  final TeamType type;
  final Widget logo;

  const Team({required this.id, required this.name, required this.type, required this.logo});
}