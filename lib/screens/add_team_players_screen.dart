import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../models/team.dart';
import '../utilities/colors.dart';
import '../widgets/cc_material_button.dart';

class AddTeamPlayersScreen extends StatefulWidget {
  const AddTeamPlayersScreen({super.key});

  @override
  State<AddTeamPlayersScreen> createState() => _AddTeamPlayersScreenState();
}

class _AddTeamPlayersScreenState extends State<AddTeamPlayersScreen> {
  int numberOfPlayer = 1;

  @override
  Widget build(BuildContext context) {
    final team = ModalRoute.of(context)?.settings.arguments as Team;
    final userId = (context.read<UserBloc>().state as UserAuthenticated)
        .user
        .userId;
    context.read<PlayerBloc>().add(LoadPlayer(userId, team.id));

    return Scaffold(
      backgroundColor: Color.gray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: team.logo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(team.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pemain ${team.name}"),
                          const SizedBox(height: 30),
                          BlocBuilder<PlayerBloc, PlayerState>(
                              builder: (context, state) {
                            if (state is PlayerLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: Color.yellow),
                              );
                            }

                            if (state is PlayerLoaded) {
                              return Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [
                                  ...state.data.map(
                                    (player) => buildPlayerInput(
                                      context,
                                      playerName: player.namaPemain,
                                    ),
                                  ),
                                  ...List.generate(
                                      numberOfPlayer,
                                      (index) => buildPlayerInput(context,
                                              onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/submit-player',
                                                arguments: team.id);
                                          })),
                                ],
                              );
                            }

                            if (state is PlayerFailed) {
                              return Center(child: Text(state.message));
                            }

                            return const SizedBox();
                          }),
                          const SizedBox(height: 24),
                          Center(
                            child: CCMaterialRedButton(
                              text: "Tambah Pemain",
                              onPressed: () {
                                setState(() {
                                  numberOfPlayer++;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: 35,
                  icon: const Icon(Icons.arrow_back))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlayerInput(BuildContext context,
      {String? playerName = "", VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: playerName,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                fillColor: Colors.white,
                enabled: false,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onPressed,
            child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(Icons.description_outlined)),
          )
        ],
      ),
    );
  }
}
