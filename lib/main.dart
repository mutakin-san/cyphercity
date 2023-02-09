import 'package:cyphercity/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/event.dart';
import '../models/team.dart';
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
import 'models/cabor.dart';
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
      RepositoryProvider(
        create: (_) => NewsRepository(),
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
        onGenerateRoute: (settings) {
          final args = settings.arguments;

          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (context) => const SplashScreen());
            case '/login':
              return MaterialPageRoute(
                  builder: (context) => const LoginScreen());
            case '/register':
              return MaterialPageRoute(
                  builder: (context) => const RegisterScreen());
            case '/main':
              return MaterialPageRoute(
                  builder: (context) => const MainScreen());
            case '/edit-biodata':
              return MaterialPageRoute(
                  builder: (context) => EditSchoolBiodataScreen(
                        kode: args as String?,
                      ));
            case '/add-team':
              return MaterialPageRoute(
                  builder: (context) => AddTeamScreen(cabor: args as Cabor));
            case '/submit-team':
              return MaterialPageRoute(
                  builder: (context) =>
                      FormAddTeamScreen(caborId: args as String));
            case '/submit-player':
              return MaterialPageRoute(
                builder: (context) =>
                    FormAddPlayerScreen(teamId: args as String),
              );
            case '/add-players':
              return MaterialPageRoute(
                builder: (context) => AddTeamPlayersScreen(team: args as Team),
              );
            case '/register-competition':
              return MaterialPageRoute(
                  builder: (context) =>
                      RegisterCompetitionScreen(event: args as Event));
            case '/information':
              return MaterialPageRoute(
                  builder: (context) => const InformationScreen());
            case '/profile':
              return MaterialPageRoute(
                  builder: (context) => ProfileScreen(userId: args as String));
            default:
              return MaterialPageRoute(
                  builder: (context) => const Scaffold(
                      body: Center(child: Text("Page Not Found"))));
          }
        },
      ),
    );
  }
}
