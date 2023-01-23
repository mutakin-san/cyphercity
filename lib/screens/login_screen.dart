import 'package:cyphercity/consts/colors.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';

import '../widgets/cc_material_button.dart';
import '../widgets/cc_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        const BrandLogo(width: 150, height: 100),
                        Form(
                          child: Column(
                            children: [
                              Text("Please Sign In",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.white)),
                              const SizedBox(height: 16),
                              CCTextFormField(
                                controller: usernameCtrl,
                                label: "Username",
                                hintText: "User Name",
                                icon: const Icon(Icons.account_circle_outlined),
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 16),
                              CCTextFormField(
                                controller: passwordCtrl,
                                icon: const Icon(Icons.lock_outlined),
                                textInputAction: TextInputAction.done,
                                isObsecure: true,
                                label: "Password",
                                hintText: "Password",
                              ),
                              const SizedBox(height: 16),
                              CCMaterialRedButton(
                                text: "Log In",
                                onPressed: () {
                                  Navigator.pushNamed(context, '/main');
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "- or create ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    child: Text("New Account -",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Color.yellow)),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Version: CC V.0.1"),
                            Text("Created by : Mutakin")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
