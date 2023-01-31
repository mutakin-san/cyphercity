// ignore_for_file: use_build_context_synchronously

import 'package:cyphercity/models/api_response.dart';
import 'package:cyphercity/utilities/colors.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:http/http.dart' as http;

import '../services/api_services.dart';
import '../services/login_pref_service.dart';
import '../widgets/cc_material_button.dart';
import '../widgets/cc_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();

  bool _isLoading = false;

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
                          key: _formKey,
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
                                validator:
                                    ValidationBuilder().required().build(),
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
                                validator: ValidationBuilder()
                                    .required()
                                    .minLength(4)
                                    .build(),
                                hintText: "Password",
                              ),
                              const SizedBox(height: 16),
                              _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                          color: Color.yellow))
                                  : CCMaterialRedButton(
                                      text: "Log In",
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          setState(() {
                                            _isLoading = true;
                                          });

                                          final apiServices =
                                              ApiServices(http.Client());

                                          final result =
                                              await apiServices.login(
                                                  username: usernameCtrl.text,
                                                  password: passwordCtrl.text);

                                          if (result.data != null) {
                                            debugPrint(
                                                "${result.data}");
                                            if(
                                              await LoginPrefService.setLogin(true) &&
                                              await LoginPrefService.setLoginDetails(result.data!.toJson())
                                            )
                                            {
                                              Navigator.pushReplacementNamed(context, '/');
                                            }
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
