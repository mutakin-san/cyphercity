import 'package:cyphercity/consts/colors.dart';
import 'package:cyphercity/widgets/cc_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';

class RegisterCompetitionScreen extends StatelessWidget {
  const RegisterCompetitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.gray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 45,
                    child: Image.asset(
                      'assets/images/cc_logo_futsal.png',
                      height: 45,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "REGISTRASI SFC VOLLEYBALL",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
