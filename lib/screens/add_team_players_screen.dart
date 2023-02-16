import 'package:cyphercity/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../models/team.dart';
import '../utilities/colors.dart';
import '../widgets/cc_material_button.dart';

class AddTeamPlayersScreen extends StatefulWidget {
  const AddTeamPlayersScreen({super.key, required this.team});

  final Team team;

  @override
  State<AddTeamPlayersScreen> createState() => _AddTeamPlayersScreenState();
}

class _AddTeamPlayersScreenState extends State<AddTeamPlayersScreen> {
  int numberOfPlayer = 1;
  late String userId;

  @override
  void initState() {
    userId = (context.read<UserBloc>().state as UserAuthenticated).user.userId;
    context.read<PlayerBloc>().add(LoadPlayer(userId, widget.team.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.gray,
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: widget.team.logo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.team.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pemain ${widget.team.name}"),
                          const SizedBox(height: 8),
                          BlocBuilder<PlayerBloc, PlayerState>(
                              builder: (context, state) {
                            if (state is PlayerLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: Color.yellow),
                              );
                            }

                            if (state is PlayerLoaded) {
                              if (state.data.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Center(
                                    child: Text(
                                      "Belum Ada Pemain!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Color.redBlack),
                                    ),
                                  ),
                                );
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: state.data
                                    .map(
                                      (player) => buildPlayerInput(
                                        context,
                                        playerName: player.namaPemain,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/submit-player',
                                              arguments: {
                                                "teamId": widget.team.id,
                                                "playerId": player.id,
                                              });
                                        },
                                        onDeleted: () async {
                                          await deletePlayer(context, player);
                                        },
                                      ),
                                    )
                                    .toList(),
                              );
                            }

                            if (state is PlayerFailed) {
                              return Center(
                                child: Column(
                                  children: [
                                    Text(state.message),
                                    TextButton.icon(
                                        onPressed: () async {
                                          context.read<PlayerBloc>().add(
                                              LoadPlayer(
                                                  userId, widget.team.id));

                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                        },
                                        icon: const Icon(Icons.refresh, color: Colors.white),
                                        label: const Text('Refresh', style: TextStyle(color: Colors.white)))
                                  ],
                                ),
                              );
                            }

                            return const SizedBox();
                          }),
                          const SizedBox(height: 24),
                          Center(
                            child: CCMaterialRedButton(
                              text: "Tambah Pemain",
                              onPressed: () {
                                Navigator.pushNamed(context, '/submit-player',
                                    arguments: {
                                      "teamId": widget.team.id,
                                      "playerId": null,
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

  Future<void> deletePlayer(BuildContext context, Player player) async {
    final playerBloc = context.read<PlayerBloc>();
    final confirmDelete = await showGeneralDialog<bool>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
        title: const Text("Apakah anda yakin?"),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Ya')),
          SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Tidak'))
        ],
      ),
    );
    if (confirmDelete != null && confirmDelete) {
      playerBloc.add(
        DeletePlayer(
          playerId: player.id,
          userId: userId,
          timId: widget.team.id,
        ),
      );
    }
  }

  Widget buildPlayerInput(BuildContext context,
      {String? playerName = "",
      VoidCallback? onPressed,
      VoidCallback? onDeleted}) {
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
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDeleted,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(4)),
              child: const Icon(
                Icons.delete,
              ),
            ),
          )
        ],
      ),
    );
  }
}
