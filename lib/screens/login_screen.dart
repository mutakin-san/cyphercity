import '../cubit/user_cubit.dart';
import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import '../widgets/cc_material_button.dart';
import '../widgets/cc_text_form_field.dart';

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
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
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
                              Text("Silahkan Masuk", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
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
                                label: "Kata Sandi",
                                validator: ValidationBuilder()
                                    .required()
                                    .minLength(4)
                                    .build(),
                                hintText: "Kata Sandi",
                              ),
                              const SizedBox(height: 16),
                              BlocBuilder<UserCubit, UserState>(
                                builder: (context, state) {
                                  if(state is UserLoading) {
                                    return Center(child: CircularProgressIndicator(color: Color.yellow));
                                  } else if(state is UserError) {
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
                                      Navigator.pushReplacementNamed(context, '/register');
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
    );
  }

  Widget buildButton(BuildContext context) {
    return CCMaterialRedButton(
      text: "Masuk",
      onPressed: () async {
        
        FocusManager.instance.primaryFocus?.unfocus();

        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          final userCubit = context.read<UserCubit>();

          await userCubit.login(
                  username: usernameCtrl.text,
                  password: passwordCtrl.text);
                  
                  
          final state = context.read<UserCubit>().state;


          if(state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        
          if(state is UserLoaded) {
            Navigator.pushReplacementNamed(context, '/');
          }


        }
      },
    );
  }
}
