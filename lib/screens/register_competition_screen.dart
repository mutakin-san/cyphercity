import '../cubit/tim_cubit.dart';
import '../models/event.dart';
import '../services/api_services.dart';
import '../utilities/colors.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_dropdown_form_field.dart';
import '../widgets/cc_material_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../cubit/school_cubit.dart';
import '../cubit/user_cubit.dart';
import '../models/tim.dart';

class RegisterCompetitionScreen extends StatefulWidget {
  const RegisterCompetitionScreen({super.key});

  @override
  State<RegisterCompetitionScreen> createState() =>
      _RegisterCompetitionScreenState();
}

class _RegisterCompetitionScreenState extends State<RegisterCompetitionScreen> {
  int _numberOfTeam = 1;
  late String _selectedTeam;

  final _formKey = GlobalKey<FormState>();

  List<Widget> buildTeamSelection(int numberOfTeam, List<Tim> teams) {
    return List.generate(numberOfTeam, (index) {
      _selectedTeam = teams.first.id;
      return CCDropdownFormField<String>(
        items: teams
            .map((e) => DropdownMenuItem(
                  value: e.id,
                  child: Text(e.namaTeam),
                ))
            .toList(),
        selectedValue: _selectedTeam,
        onChanged: (value) {
          setState(() {
            _selectedTeam = value ?? _selectedTeam;
          });
        },
        label: "Select Team",
        labelColor: Colors.black,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    final schoolState = context.read<SchoolCubit>().state;
    if (schoolState is SchoolLoaded) {
      final user = (context.read<UserCubit>().state as UserLoaded).user;
      context.read<TimCubit>().loadTim(user.userId, schoolState.data.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)?.settings.arguments as Event;
    return Scaffold(
      backgroundColor: Color.gray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      BlocBuilder<SchoolCubit, SchoolState>(
                        builder: (context, state) {
                          if (state is SchoolLoaded) {
                            return BrandLogo(
                              width: 50,
                              height: 50,
                              logoUrl: state
                                  .data
                                  .logo,
                            );
                          }

                          return const SizedBox(height: 50);
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        event.namaEvent,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: BlocBuilder<TimCubit, TimState>(
                            builder: (context, state) {
                              if (state is TimInitial) {
                                return Center(
                                    child: CircularProgressIndicator(
                                        color: Color.yellow));
                              }
                              if (state is TimFailed) {
                                return Center(child: Text(state.message));
                              }
                              final data = (state as TimLoaded).data;

                              return Column(
                                children: [
                                  CCDropdownFormField<int>(
                                    items: List.generate(data.length, (index) {
                                      return DropdownMenuItem(
                                        value: index + 1,
                                        child: Text("${index + 1}"),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _numberOfTeam = value ?? _numberOfTeam;
                                      });
                                    },
                                    label: "Number of Teams",
                                    labelColor: Colors.black,
                                    selectedValue:
                                        data.isNotEmpty ? _numberOfTeam : 0,
                                  ),
                                  ...buildTeamSelection(_numberOfTeam, data),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                          "If you haven't created a team yet, "),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          "Click Here",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Color.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Center(
                                      child: CCMaterialRedButton(
                                          onPressed: () async {
                                            final idSekolah = (context
                                                    .read<SchoolCubit>()
                                                    .state as SchoolLoaded)
                                                .data
                                                .id;
                                            final idUser = (context
                                                    .read<UserCubit>()
                                                    .state as UserLoaded)
                                                .user
                                                .userId;
                                            final result =
                                                await ApiServices(http.Client())
                                                    .registerEvent(
                                                        idEvent: event.id,
                                                        idUser: idUser,
                                                        idSekolah: idSekolah,
                                                        idTim: _selectedTeam);

                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "${result.message}")));
                                          },
                                          text: "REG")),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      iconSize: 35,
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
