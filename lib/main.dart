import 'package:cyphercity/consts/colors.dart';
import 'package:cyphercity/screens/login_screen.dart';
import 'package:cyphercity/screens/register_screen.dart';
import 'package:cyphercity/screens/splash_screen.dart';
import 'package:cyphercity/screens/team_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import 'screens/home_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Team',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
      ).copyWith(
        primaryColor: Color.redPurple,
        colorScheme: const ColorScheme.light().copyWith(
          primary: Color.redPurple,
          onPrimary: Colors.white,
          onBackground: Colors.white,
          secondary: Color.red,
          onSecondary: Colors.white,
          onSurface: Colors.white
        )
      ),
      initialRoute: '/',
      routes: {
        '/' :(context) => const SplashScreen(),
        '/login' : (context) => const LoginScreen(),
        '/register' : (context) => const RegisterScreen(),
        '/main' : (context) => const MainScreen(),
        '/team-information' : (context) => const TeamInformationScreen(),

      },
    );
  }
}