// ignore_for_file: use_build_context_synchronously

import 'package:cyphercity/services/api_services.dart';
import 'package:cyphercity/services/login_pref_service.dart';
import 'package:cyphercity/utilities/colors.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../widgets/cc_material_button.dart';
import '../widgets/cc_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController usernameCtrl = TextEditingController();

  final TextEditingController noHpCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();

  final TextEditingController confirmPasswordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

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
                        key: _formKey,
                        child: Column(
                          children: [
                            CCTextFormField(
                              controller: emailCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.email_outlined),
                              hintText: "Alamat Email",
                              label: "Alamat Email",
                              validator: ValidationBuilder()
                                  .required()
                                  .email()
                                  .build(),
                            ),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              controller: usernameCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.person_outline),
                              hintText: "Username",
                              label: "Username",
                              validator: ValidationBuilder().required().build(),
                            ),
                            const SizedBox(height: 16),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              controller: nameCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.person_outline),
                              hintText: "Nama Lengkap",
                              label: "Nama Lengkap",
                              validator: ValidationBuilder().required().build(),
                            ),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              controller: noHpCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.school_outlined),
                              hintText: "No Hp",
                              label: "No Hp",
                              validator: ValidationBuilder().required().build(),
                            ),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              controller: passwordCtrl,
                              textInputAction: TextInputAction.next,
                              icon: const Icon(Icons.lock_outline),
                              isObsecure: true,
                              hintText: "Kata Sandi",
                              label: "Kata Sandi",
                              validator: ValidationBuilder()
                                  .required()
                                  .minLength(6)
                                  .build(),
                            ),
                            const SizedBox(height: 16),
                            CCTextFormField(
                              textInputAction: TextInputAction.done,
                              controller: confirmPasswordCtrl,
                              isObsecure: true,
                              icon: const Icon(Icons.lock_outline),
                              hintText: "Ulangi Kata Sandi",
                              label: "Ulangi Kata Sandi",
                              validator: ValidationBuilder()
                                  .required()
                                  .add((value) => (value != null &&
                                          value == passwordCtrl.text)
                                      ? null
                                      : "Password doesn't match")
                                  .build(),
                            ),
                            const SizedBox(height: 16),
                            _isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: Color.yellow))
                                : CCMaterialRedButton(
                                    text: "Sign Up",
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        setState(() {
                                          _isLoading = true;
                                        });

                                        final apiServices =
                                            ApiServices(http.Client());

                                        final result =
                                            await apiServices.register(
                                                email: emailCtrl.text,
                                                username: usernameCtrl.text,
                                                name: nameCtrl.text,
                                                password: passwordCtrl.text,
                                                confirmPassword:
                                                    confirmPasswordCtrl.text);

                                       if (result.data != null) {
                                            debugPrint(
                                                "${result.data as User}");
                                            await LoginPrefService.setLogin(true);
                                            await LoginPrefService.setLoginDetails(result.data!.toJson());

                                            Navigator.pushReplacementNamed(context, '/');
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(result.message!)),
                                            );
                                          }

                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
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
