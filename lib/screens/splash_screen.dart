import 'dart:async';

import 'package:cyphercity/cubit/user_cubit.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/login_pref_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    LoginPrefService.isLogin.asStream().listen((isLogin) {
      if(isLogin) {
        context.read<UserCubit>().loadUser().then((value) => Navigator.pushReplacementNamed(context, '/main'));
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: const TextStyle(color: Colors.white, height: 1.5),
      child: Stack(
        children: const [
          BackgroundGradient(),
          Center(
            child: BrandLogo(width: 150, height: 150,),
          )
        ],
      ),
    );
  }
}
