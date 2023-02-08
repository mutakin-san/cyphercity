import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../bloc/bloc.dart';
import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_dropdown_form_field.dart';
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

  int _selectedUserType = 0;

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
                        Text("Buat Akun Baru",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white)),
                        const SizedBox(height: 45),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CCDropdownFormField(
                                  label: 'Tipe Akun',
                                  items: [0, 1]
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                              e == 0 ? "Pribadi" : "Sekolah")))
                                      .toList(),
                                  selectedValue: _selectedUserType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedUserType = value ?? 0;
                                    });
                                  }),
                              const SizedBox(height: 16),
                              CCTextFormField(
                                controller: emailCtrl,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.emailAddress,
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
                                validator:
                                    ValidationBuilder().required().build(),
                              ),
                              const SizedBox(height: 16),
                              CCTextFormField(
                                controller: nameCtrl,
                                textInputAction: TextInputAction.next,
                                icon: const Icon(Icons.person_outline),
                                hintText: "Nama Lengkap",
                                label: "Nama Lengkap",
                                validator:
                                    ValidationBuilder().required().build(),
                              ),
                              const SizedBox(height: 16),
                              CCTextFormField(
                                controller: noHpCtrl,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.phone,
                                icon: const Icon(Icons.school_outlined),
                                hintText: "No Hp",
                                label: "No Hp",
                                validator:
                                    ValidationBuilder().required().build(),
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
                                        : "Kata Sandi Tidak Cocok")
                                    .build(),
                              ),
                              const SizedBox(height: 16),
                              BlocBuilder<UserBloc, UserState>(
                                builder: (context, state) {
                                  if (state is UserLoading) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                            color: Color.yellow));
                                  } else {
                                    return buildButton(context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sudah punya akun? ",
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
                                    context, '/login');
                              },
                              child: Text("Masuk Sekarang",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Color.yellow)),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
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
      text: "Daftar",
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();

        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          context.read<UserBloc>().add(UserRegister(
                email: emailCtrl.text,
                username: usernameCtrl.text,
                name: nameCtrl.text,
                password: passwordCtrl.text,
                confirmPassword: confirmPasswordCtrl.text,
                noHp: noHpCtrl.text,
                statusSekolah: _selectedUserType,
              ));
        }
      },
    );
  }
}
