import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/add_team_players_screen.dart';
import '../screens/add_team_screen.dart';
import '../screens/edit_school_biodata_screen.dart';
import '../screens/form_add_player_screen.dart';
import '../screens/form_add_team_screen.dart';
import '../screens/information_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_competition_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';
import '../utilities/colors.dart';
import 'bloc/bloc.dart';
import 'core/repos/repositories.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (_) => UserRepository(),
      ),
      RepositoryProvider(
        create: (_) => SchoolRepository(),
      ),
      RepositoryProvider(
        create: (_) => TeamRepository(),
      ),
      RepositoryProvider(
        create: (_) => EventRepository(),
      ),
      RepositoryProvider(
        create: (_) => CaborRepository(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final userRepo = RepositoryProvider.of<UserRepository>(context);
            return UserBloc(userRepo);
          },
        ),
        BlocProvider(
          create: (_) {
            final schoolRepo = RepositoryProvider.of<SchoolRepository>(context);
            return SchoolBloc(schoolRepo);
          },
        ),
        BlocProvider(
          create: (_) {
            final teamRepo = RepositoryProvider.of<TeamRepository>(context);
            return TimBloc(teamRepo);
          },
        ),
        BlocProvider(
          create: (_) {
            final teamRepo = RepositoryProvider.of<TeamRepository>(context);
            return PlayerBloc(teamRepo);
          },
        )
      ],
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
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/main': (context) => const MainScreen(),
          '/edit-biodata': (context) => const EditSchoolBiodataScreen(),
          '/add-team': (context) => const AddTeamScreen(),
          '/submit-team': (context) => const FormAddTeamScreen(),
          '/submit-player': (context) => const FormAddPlayerScreen(),
          '/add-players': (context) => const AddTeamPlayersScreen(),
          '/register-competition': (context) =>
              const RegisterCompetitionScreen(),
          '/information': (context) => const InformationScreen()
        },
      ),
    );
  }
}
