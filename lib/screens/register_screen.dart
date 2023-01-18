import 'package:cyphercity/consts/colors.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                            TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                        Icons.email_outlined),
                                    hintText: "Alamat Email",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10))),
                            const SizedBox(height: 16),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                        Icons.person_outline),
                                    hintText: "Nama Lengkap",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10))),
                            const SizedBox(height: 16),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                        Icons.school_outlined),
                                    hintText: "Nama Sekolah",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10))),
                            const SizedBox(height: 16),
                            TextFormField(
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                        Icons.lock_outline),
                                    hintText: "Kata Sandi",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10))),
                            const SizedBox(height: 16),
                            TextFormField(
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(
                                        Icons.lock_outline),
                                    hintText: "Ulangi Kata Sandi",
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10))),
                            const SizedBox(height: 16),
                            MaterialButton(
                                color: Color.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                minWidth: 150,
                                height: 45,
                                textColor: Colors.white,
                                onPressed: () {
                                   Navigator.pushNamed(context, '/main');
                                },
                                child: const Text("Sign Up")),
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
