import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';

import '../widgets/cc_text_form_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController schoolNameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      const BrandLogo(width: 150, height: 100),
                      Text("Create New Account",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white)),
                      const SizedBox(height: 45),
                      Form(
                        child: Column(
                          children: [
                            CCTextFormField(
                              controller: emailCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.email_outlined),
                              hintText: "Alamat Email",
                              label: "Alamat Email",
                            ),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              controller: nameCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.person_outline),
                              hintText: "Nama Lengkap",
                              label: "Nama Lengkap",
                            ),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              controller: schoolNameCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.school_outlined),
                              hintText: "Nama Sekolah",
                              label: "Nama Sekolah",
                            ),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              controller: passwordCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.lock_outline),
                              hintText: "Kata Sandi",
                              label: "Kata Sandi",
                            ),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              textInputAction: TextInputAction.done,
                              controller: confirmPasswordCtrl,
                              isObsecure: true,
                              icon: const Icon(Icons.lock_outline),
                              hintText: "Ulangi Kata Sandi",
                              label: "Ulangi Kata Sandi",
                            ),
                            const SizedBox(height: 16),
                            CCMaterialRedButton(
                              text: "Sign Up",
                              onPressed: () {
                                Navigator.pushNamed(context, '/main');
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
