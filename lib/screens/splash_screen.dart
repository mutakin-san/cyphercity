import 'dart:async';

import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
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
