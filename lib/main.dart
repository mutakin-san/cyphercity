import 'package:cyphercity/utilities/colors.dart';
import 'package:cyphercity/screens/add_team_players_screen.dart';
import 'package:cyphercity/screens/add_team_screen.dart';
import 'package:cyphercity/screens/edit_team_biodata_screen.dart';
import 'package:cyphercity/screens/form_add_player_screen.dart';
import 'package:cyphercity/screens/form_add_team_screen.dart';
import 'package:cyphercity/screens/information_screen.dart';
import 'package:cyphercity/screens/login_screen.dart';
import 'package:cyphercity/screens/register_competition_screen.dart';
import 'package:cyphercity/screens/register_screen.dart';
import 'package:cyphercity/screens/splash_screen.dart';
import 'package:cyphercity/screens/team_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/user_cubit.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: MaterialApp(
        title: 'Manajemen Team',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            primaryColor: Color.redPurple,
            colorScheme: const ColorScheme.light().copyWith(
              primary: Color.redPurple,
              onPrimary: Colors.white,
              onBackground: Colors.white,
              secondary: Color.red,
              onSecondary: Colors.white,
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/main': (context) => const MainScreen(),
          '/team-information': (context) => const TeamInformationScreen(),
          '/edit-biodata': (context) => EditTeamBiodataScreen(),
          '/add-team': (context) => const AddTeamScreen(),
          '/submit-team': (context) => FormAddTeamScreen(),
          '/submit-player': (context) => FormAddPlayerScreen(),
          '/add-players': (context) => const AddTeamPlayersScreen(),
          '/register-competition': (context) =>
              const RegisterCompetitionScreen(),
          '/information': (context) => const InformationScreen()
        },
      ),
    );
  }
}
