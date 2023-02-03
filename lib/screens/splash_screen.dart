import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../bloc/user_bloc.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUser());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserAuthenticated) {
              context.read<SchoolBloc>().add(LoadSchool(state.user.userId));
            }

            if (state is UserNotAuthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (_) => false);
            }
          },
        ),
        BlocListener<SchoolBloc, SchoolState>(
          listener: (context, state) {
            Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
          },
        ),
      ],
      child: Material(
        textStyle: const TextStyle(color: Colors.white, height: 1.5),
        child: Stack(
          children: const [
            BackgroundGradient(),
            Center(
              child: BrandLogo(
                width: 150,
                height: 150,
              ),
            )
          ],
        ),
      ),
    );
  }
}
