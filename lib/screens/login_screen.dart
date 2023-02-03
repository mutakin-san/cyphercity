import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_material_button.dart';
import '../widgets/cc_text_form_field.dart';
import '../bloc/bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error ?? "")));
        }

        if (state is UserAuthenticated) {
          context.read<SchoolBloc>().add(LoadSchool(state.user.userId));
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        }

      },
      child: Scaffold(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(),
                          const BrandLogo(width: 150, height: 100),
                          const SizedBox(height: 30),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text("Silahkan Masuk",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.white)),
                                const SizedBox(height: 16),
                                CCTextFormField(
                                  controller: usernameCtrl,
                                  label: "Username",
                                  hintText: "User Name",
                                  validator:
                                      ValidationBuilder().required().build(),
                                  icon:
                                      const Icon(Icons.account_circle_outlined),
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 16),
                                CCTextFormField(
                                  controller: passwordCtrl,
                                  icon: const Icon(Icons.lock_outlined),
                                  textInputAction: TextInputAction.done,
                                  isObsecure: true,
                                  label: "Kata Sandi",
                                  validator: ValidationBuilder()
                                      .required()
                                      .minLength(4)
                                      .build(),
                                  hintText: "Kata Sandi",
                                ),
                                const SizedBox(height: 16),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLoading) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                              color: Color.yellow));
                                    } else if (state is UserError) {
                                      return buildButton(context);
                                    } else {
                                      return buildButton(context);
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Belum punya akun? ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/register');
                                      },
                                      child: Text("Buat Sekarang",
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return CCMaterialRedButton(
      text: "Masuk",
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();

        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          context.read<UserBloc>().add(UserLogin(usernameCtrl.text, passwordCtrl.text));
        }
      },
    );
  }
}
