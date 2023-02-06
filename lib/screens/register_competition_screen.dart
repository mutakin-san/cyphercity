import '../bloc/bloc.dart';
import '../models/event.dart';
import '../services/api_services.dart';
import '../utilities/colors.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_dropdown_form_field.dart';
import '../widgets/cc_material_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  late String userId;
  late String schoolId;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userId = (context.read<UserBloc>().state as UserAuthenticated).user.userId;
    schoolId = (context.read<SchoolBloc>().state as SchoolLoaded).data.id;
    super.initState();
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
                      const BrandLogo(
                          width: 50,
                          height: 50),
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
                          child: Builder(builder: (_) {
                            if (userId.isNotEmpty && schoolId.isNotEmpty) {
                              context
                                  .read<TimBloc>()
                                  .add(LoadTim(userId, schoolId));
                            }

                            return Column(
                              children: [
                                BlocBuilder<TimBloc, TimState>(
                                  builder: (context, state) {
                                    if (state is TimLoaded) {
                                      return Column(
                                        children: [
                                          CCDropdownFormField<int>(
                                            items: List.generate(
                                                state.data.length, (index) {
                                              return DropdownMenuItem(
                                                value: index + 1,
                                                child: Text("${index + 1}"),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _numberOfTeam = value!;
                                              });
                                            },
                                            label: "Number of Teams",
                                            labelColor: Colors.black,
                                            selectedValue: _numberOfTeam,
                                          ),
                                          ...buildTeamSelection(
                                              _numberOfTeam, state.data)
                                        ],
                                      );
                                    }

                                    return const SizedBox();
                                  },
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "If you haven't created a team yet, "),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/submit-team');
                                      },
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
                                      onPressed: _numberOfTeam > 0 ? () async {
                                        if (userId.isNotEmpty &&
                                            schoolId.isNotEmpty) {
                                          final result =
                                              await ApiServices(http.Client())
                                                  .registerEvent(
                                                      idEvent: event.id,
                                                      idUser: userId,
                                                      idSekolah: schoolId,
                                                      idTim: _selectedTeam);

                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "${result.message}")));
                                        }
                                      } : null,
                                      text: "REG"),
                                ),
                              ],
                            );
                          }),
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
}
