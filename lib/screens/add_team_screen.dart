import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/bloc.dart';
import '../models/cabor.dart';
import '../models/team.dart';
import '../utilities/colors.dart';
import '../utilities/config.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';

class AddTeamScreen extends StatefulWidget {
  const AddTeamScreen({super.key, required this.cabor});

  final Cabor cabor;

  @override
  State<AddTeamScreen> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  late String userId;
  late String schoolId;

  @override
  void initState() {
    userId = (context.read<UserBloc>().state as UserAuthenticated).user.userId;
    schoolId = (context.read<SchoolBloc>().state as SchoolLoaded).data.id;
    context.read<TimBloc>().add(LoadTim(userId, schoolId, widget.cabor.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TimBloc>().add(LoadTim(userId, schoolId, widget.cabor.id));
        await Future.delayed(const Duration(seconds: 1));
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        const BrandLogo(width: 50, height: 50),
                        BlocSelector<SchoolBloc, SchoolState, String>(
                            selector: (state) => state is SchoolLoaded
                                ? state.data.namaSekolah
                                : "",
                            builder: (context, name) {
                              return Text(
                                name,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.white),
                              );
                            }),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 50),
                                  decoration: BoxDecoration(
                                    color: Color.gray,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      BlocSelector<SchoolBloc, SchoolState,
                                              String>(
                                          selector: (state) =>
                                              state is SchoolLoaded
                                                  ? state.data.gambar
                                                  : "",
                                          builder: (context, gambar) {
                                            return Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Color.purple,
                                                image: DecorationImage(
                                                    image: CachedNetworkImageProvider((gambar
                                                            .isNotEmpty)
                                                        ? "$baseImageUrlTim/$gambar"
                                                        : "https://via.placeholder.com/480x300"),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                ),
                                              ),
                                            );
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: BlocBuilder<TimBloc, TimState>(
                                          builder: (context, state) {
                                            if (state is TimLoaded) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  AddTeamList(
                                                      title: widget
                                                          .cabor.namaCabor,
                                                      createNewPressed: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/submit-team',
                                                            arguments: widget
                                                                .cabor.id);
                                                      },
                                                      teams: state.data
                                                          .map((tim) => Team(
                                                              id: tim.id,
                                                              name:
                                                                  tim.namaTeam,
                                                              type: TeamType.PA,
                                                              logo: Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image: CachedNetworkImageProvider(tim.logoTeam !=
                                                                                null &&
                                                                            tim.logoTeam!.isNotEmpty
                                                                        ? "$baseImageUrlTim/${tim.logoTeam}"
                                                                        : "$baseImageUrlCabor/${widget.cabor.gambar}"),
                                                                  ),
                                                                ),
                                                              )))
                                                          .toList()),
                                                ],
                                              );
                                            }

                                            if (state is TimFailed) {
                                              return Center(
                                                  child: Text(state.message,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge));
                                            }

                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Color.yellow));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              "$baseImageUrlCabor/${widget.cabor.gambar}"),
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddTeamList extends StatefulWidget {
  const AddTeamList({
    Key? key,
    required this.title,
    required this.createNewPressed,
    required this.teams,
  }) : super(key: key);

  final String title;
  final List<Team> teams;
  final VoidCallback createNewPressed;

  @override
  State<AddTeamList> createState() => _AddTeamListState();
}

class _AddTeamListState extends State<AddTeamList> {
  XFile? newLogo;

  Future<XFile?> pickTeamLogo() async {
    final imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    return image;
  }

  updateNewLogo(XFile? image, setState) {
    setState(() {
      newLogo = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final timBloc = context.read<TimBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(widget.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Color.red)),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            ...widget.teams.map(
              (team) {
                return TeamItem(
                  name: team.name,
                  logo: team.logo,
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-players',
                        arguments: team);
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              BlocConsumer<TimBloc, TimState>(
                                listener: (context, state) {
                                  if (state is TimLoaded) {
                                    newLogo = null;
                                    Future.delayed(const Duration(seconds: 1))
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  }

                                  if (state is TimFailed) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(state.message)));

                                    Navigator.pop(context);
                                  }
                                },
                                builder: (_, state) {
                                  if (state is TimLoading) {
                                    return CircularProgressIndicator(
                                        color: Color.yellow);
                                  }
                                  return ElevatedButton.icon(
                                    onPressed: () {
                                      if (newLogo != null) {
                                        timBloc
                                            .add(UpdateLogo(team.id, newLogo!));
                                      }
                                    },
                                    icon: const Icon(Icons.check),
                                    label: const Text("Simpan"),
                                  );
                                },
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.clear),
                                label: const Text("Cancel"),
                              ),
                            ],
                            title: const Text(
                              "Update Logo Team",
                              textAlign: TextAlign.center,
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  StatefulBuilder(builder: (context, setState) {
                                    return GestureDetector(
                                      onTap: () async {
                                        final pickedImage =
                                            await pickTeamLogo();

                                        if (pickedImage != null) {
                                          updateNewLogo(pickedImage, setState);
                                        }
                                      },
                                      child: newLogo != null
                                          ? Stack(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    color: Color.redPurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: FileImage(
                                                          File(newLogo!.path),
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 0,
                                                  child: IconButton(
                                                    color: Color.yellow,
                                                    onPressed: () {
                                                      updateNewLogo(
                                                          null, setState);
                                                    },
                                                    icon:
                                                        const Icon(Icons.clear),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: Color.redPurple,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.file_upload_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                );
              },
            ),
            GestureDetector(
              onTap: widget.createNewPressed,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add, size: 45),
                  ),
                  const SizedBox(height: 8),
                  Text("Tambah Tim",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.bodyMedium?.copyWith()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ignore: constant_identifier_names
enum TeamType { PA, PI }

class TeamItem extends StatelessWidget {
  const TeamItem(
      {Key? key,
      required this.name,
      required this.logo,
      this.onPressed,
      this.onLongPress})
      : super(key: key);
  final String name;
  final Widget logo;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3.5,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: logo,
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith()),
            ),
          ],
        ),
      ),
    );
  }
}
