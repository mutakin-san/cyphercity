import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../core/repos/repositories.dart';
import '../models/event.dart';
import '../models/tim.dart';
import '../utilities/colors.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_dropdown_form_field.dart';
import '../widgets/cc_material_button.dart';

class RegisterCompetitionScreen extends StatefulWidget {
  const RegisterCompetitionScreen({super.key, required this.event});

  final Event event;

  @override
  State<RegisterCompetitionScreen> createState() =>
      _RegisterCompetitionScreenState();
}

class _RegisterCompetitionScreenState extends State<RegisterCompetitionScreen> {
  int _numberOfTeam = 1;
  List<int> _selectedTeams = [];
  bool isLoading = false;

  late String userId;
  late String schoolId;

  final _formKey = GlobalKey<FormState>();

  late TimBloc timBloc;
  late final eventBloc =
      EventBloc(RepositoryProvider.of<EventRepository>(context));

  @override
  void initState() {
    userId = (context.read<UserBloc>().state as UserAuthenticated).user.userId;
    schoolId = (context.read<SchoolBloc>().state as SchoolLoaded).data.id;
    timBloc = context.read<TimBloc>();
    if (userId.isNotEmpty && schoolId.isNotEmpty) {
      timBloc.add(LoadTim(userId, schoolId, widget.event.idCabor));
    }
    super.initState();
  }

  @override
  void dispose() {
    eventBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (userId.isNotEmpty && schoolId.isNotEmpty) {
          timBloc.add(LoadTim(userId, schoolId, widget.event.idCabor));
        }

        await Future.delayed(const Duration(seconds: 1));
      },
      child: Scaffold(
        backgroundColor: Color.gray,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 16),
                            const BrandLogo(width: 50, height: 50),
                            const SizedBox(height: 16),
                            Text(
                              widget.event.namaEvent,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            Form(
                              key: _formKey,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Column(
                                    children: [
                                      BlocBuilder<TimBloc, TimState>(
                                        builder: (context, state) {
                                          if (state is TimLoaded) {
                                            return Column(
                                              children: [
                                                CCDropdownFormField<int>(
                                                  items: List.generate(
                                                      state.data.length,
                                                      (index) {
                                                    return DropdownMenuItem(
                                                      value: index + 1,
                                                      child:
                                                          Text("${index + 1}"),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _numberOfTeam = value!;
                                                      if (_selectedTeams
                                                              .length <
                                                          _numberOfTeam) {
                                                        _selectedTeams.addAll(
                                                            List.generate(
                                                                _numberOfTeam -
                                                                    _selectedTeams
                                                                        .length,
                                                                (index) => int
                                                                    .parse(state
                                                                        .data
                                                                        .first
                                                                        .id)));
                                                      } else {
                                                        _selectedTeams
                                                            .removeRange(
                                                                _numberOfTeam,
                                                                _selectedTeams
                                                                    .length);
                                                      }
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

                                          if (state is TimFailed) {
                                            return Center(
                                                child: Text(state.message));
                                          }

                                          return Center(
                                              child: CircularProgressIndicator(
                                                  color: Color.yellow));
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                              "If you haven't created a team yet, "),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/submit-team',
                                                  arguments: {
                                                    "caborId":
                                                        widget.event.idCabor,
                                                  });
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
                                        child:
                                            BlocConsumer<EventBloc, EventState>(
                                          bloc: eventBloc,
                                          listener: (context, state) {
                                            if (state is RegisterEventSucces) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Berhasil registrasi event!!")));
                                            }

                                            if (state is EventFailed) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text(state.error)));
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state is EventLoading) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Color.yellow));
                                            }

                                            return CCMaterialRedButton(
                                                onPressed: _numberOfTeam > 0
                                                    ? () async {
                                                        if (userId.isNotEmpty &&
                                                            schoolId
                                                                .isNotEmpty) {
                                                          for (var idTeam
                                                              in _selectedTeams) {
                                                            eventBloc.add(
                                                                RegisterEvent(
                                                              idEvent: widget
                                                                  .event.id,
                                                              idUser: userId,
                                                              idSekolah:
                                                                  schoolId,
                                                              idCabor: widget
                                                                  .event
                                                                  .idCabor,
                                                              idTim: idTeam
                                                                  .toString(),
                                                            ));
                                                          }
                                                        }
                                                      }
                                                    : null,
                                                text: "REG");
                                          },
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            iconSize: 35,
                            icon: const Icon(Icons.arrow_back))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildTeamSelection(int numberOfTeam, List<Tim> teams) {
    if (teams.isNotEmpty) {
      if (_selectedTeams.isEmpty) {
        _selectedTeams =
            List.generate(_numberOfTeam, (index) => int.parse(teams.first.id));
      }
      return List.generate(numberOfTeam, (index) {
        int selectedTeam = int.parse(teams.first.id);
        return CCDropdownFormField<int>(
          items: teams
              .map((e) => DropdownMenuItem(
                    value: int.parse(e.id),
                    child: Text(e.namaTeam),
                  ))
              .toList(),
          selectedValue: selectedTeam,
          onChanged: (value) {
            selectedTeam = value!;
            _selectedTeams[index] = selectedTeam;
          },
          label: "Select Team",
          labelColor: Colors.black,
        );
      });
    } else {
      return [];
    }
  }
}
