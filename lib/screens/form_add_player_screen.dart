import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyphercity/utilities/config.dart';
import 'package:cyphercity/utilities/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../utilities/colors.dart';
import '../widgets/cc_material_button.dart';
import '../widgets/cc_text_form_field.dart';

class FormAddPlayerScreen extends StatefulWidget {
  const FormAddPlayerScreen({super.key, required this.teamId, this.playerId});

  final String teamId;
  final String? playerId;

  @override
  State<FormAddPlayerScreen> createState() => _FormAddPlayerScreenState();
}

class _FormAddPlayerScreenState extends State<FormAddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController playerNameCtrl = TextEditingController();

  final TextEditingController tanggalLahirCtrl = TextEditingController();

  final TextEditingController nisnCtrl = TextEditingController();

  final TextEditingController posisiCtrl = TextEditingController();

  final TextEditingController nomorPunggungCtrl = TextEditingController();

  DateTime selectedDate = DateTime.now();

  XFile? _fotoPlayer;
  XFile? _aktaPlayer;
  XFile? _kkPlayer;

  String? fotoPlayerUrl;
  String? aktaPlayerUrl;
  String? kkPlayerUrl;

  Future<String> pickDate(BuildContext context) async {
    final selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2025));

    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
    }

    return DateFormat("yyyy-MM-dd").format(selectedDate);
  }

  Future<void> getFotoPlayer(BuildContext context) async {
    final source = await chooseImageSource(context);
    if (source != null) {
      await pickImage(
        source: source,
        onChoosed: (image) {
          if (image != null) {
            setState(() {
              _fotoPlayer = image;
            });
          }
        },
      );
    }
  }

  Future<void> getAktaPlayer(BuildContext context) async {
    final source = await chooseImageSource(context);
    if (source != null) {
      await pickImage(
        source: source,
        onChoosed: (image) {
          if (image != null) {
            setState(() {
              _aktaPlayer = image;
            });
          }
        },
      );
    }
  }

  Future<void> getKkPlayer(BuildContext context) async {
    final source = await chooseImageSource(context);
    if (source != null) {
      await pickImage(
        source: source,
        onChoosed: (image) {
          if (image != null) {
            setState(() {
              _kkPlayer = image;
            });
          }
        },
      );
    }
  }

  @override
  void initState() {
    if (widget.playerId != null) {
      try {
        final player = (context.read<PlayerBloc>().state as PlayerLoaded)
            .data
            .singleWhere((element) => element.id == widget.playerId);
        playerNameCtrl.text = player.namaPemain;
        tanggalLahirCtrl.text = player.tglLahir;
        nisnCtrl.text = player.nisn;
        posisiCtrl.text = player.posisi;
        nomorPunggungCtrl.text = player.noPunggung;

        fotoPlayerUrl = "$baseImageUrlPlayer/${player.foto}";
        kkPlayerUrl = "$baseImageUrlPlayer/${player.kk}";
        aktaPlayerUrl = "$baseImageUrlPlayer/${player.aktaLahir}";
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (_, state) {
        if (state is PlayerCreated) {
          if (state.message != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
          final userId =
              (context.read<UserBloc>().state as UserAuthenticated).user.userId;
          context.read<PlayerBloc>().add(LoadPlayer(userId, widget.teamId));

          Future.delayed(const Duration(seconds: 2))
              .then((value) => Navigator.pop(context));
        }

        if (state is PlayerFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
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
                      const SizedBox(height: 8),
                      Text("Tambah Pemain",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            CCTextFormField(
                                controller: playerNameCtrl,
                                label: "Nama Pemain",
                                textColor: Colors.black,
                                validator:
                                    ValidationBuilder().required().build(),
                                textInputAction: TextInputAction.next),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                final date = await pickDate(context);
                                tanggalLahirCtrl.text = date;
                              },
                              child: CCTextFormField(
                                  controller: tanggalLahirCtrl,
                                  label: "Tanggal Lahir",
                                  enabled: false,
                                  hintText: "Pilih Tanggal Lahir",
                                  textColor: Colors.black,
                                  validator:
                                      ValidationBuilder().required().build(),
                                  textInputAction: TextInputAction.next),
                            ),
                            const SizedBox(height: 8),
                            CCTextFormField(
                                controller: nisnCtrl,
                                label: "NISN",
                                textColor: Colors.black,
                                inputType: TextInputType.number,
                                validator:
                                    ValidationBuilder().required().build(),
                                textInputAction: TextInputAction.next),
                            const SizedBox(height: 8),
                            CCTextFormField(
                                controller: posisiCtrl,
                                label: "Posisi",
                                validator:
                                    ValidationBuilder().required().build(),
                                textColor: Colors.black,
                                textInputAction: TextInputAction.next),
                            const SizedBox(height: 8),
                            CCTextFormField(
                                controller: nomorPunggungCtrl,
                                label: "Nomor Punggung",
                                textColor: Colors.black,
                                inputType: TextInputType.number,
                                validator:
                                    ValidationBuilder().required().build(),
                                textInputAction: TextInputAction.done),
                            const SizedBox(height: 8),
                            Center(
                              child: Text("Upload Dokumen",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: _fotoPlayer != null
                                  ? Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      File(_fotoPlayer!.path)),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                              color: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _fotoPlayer = null;
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.close_rounded)),
                                        ),
                                      ],
                                    )
                                  : fotoPlayerUrl != null
                                      ? Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        fotoPlayerUrl!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: IconButton(
                                              color: Color.yellow,
                                              onPressed: () =>
                                                  getFotoPlayer(context),
                                              icon: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black45,
                                                        blurRadius: 10,
                                                        spreadRadius: 4)
                                                  ],
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.edit),
                                              )),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            getFotoPlayer(context);
                                          },
                                          child: Column(
                                            children: [
                                              const Icon(
                                                  Icons.description_rounded),
                                              const Text("Foto Pemain"),
                                              Text(
                                                "Upload Disini",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Color.red),
                                              ),
                                            ],
                                          ),
                                        ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: _aktaPlayer != null
                                  ? Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      File(_aktaPlayer!.path)),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                              color: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _aktaPlayer = null;
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.close_rounded)),
                                        ),
                                      ],
                                    )
                                  : aktaPlayerUrl != null
                                      ? Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        aktaPlayerUrl!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: IconButton(
                                              color: Color.yellow,
                                              onPressed: () =>
                                                  getAktaPlayer(context),
                                              icon: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black45,
                                                        blurRadius: 10,
                                                        spreadRadius: 4)
                                                  ],
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.edit),
                                              )),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await getAktaPlayer(context);
                                          },
                                          child: Column(
                                            children: [
                                              const Icon(
                                                  Icons.description_rounded),
                                              const Text("Akta Kelahiran"),
                                              Text(
                                                "Upload Disini",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Color.red),
                                              ),
                                            ],
                                          ),
                                        ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: _kkPlayer != null
                                  ? Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      File(_kkPlayer!.path)),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                              color: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _kkPlayer = null;
                                                });
                                              },
                                              icon: const Icon(
                                                  Icons.close_rounded)),
                                        ),
                                      ],
                                    )
                                  : kkPlayerUrl != null
                                      ? Container(
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        kkPlayerUrl!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: IconButton(
                                              color: Color.yellow,
                                              onPressed: () =>
                                                  getKkPlayer(context),
                                              icon: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black45,
                                                        blurRadius: 10,
                                                        spreadRadius: 4)
                                                  ],
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.edit),
                                              )),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await getKkPlayer(context);
                                          },
                                          child: Column(
                                            children: [
                                              const Icon(
                                                  Icons.description_rounded),
                                              const Text("Kartu Keluarga"),
                                              Text(
                                                "Upload Disini",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Color.red),
                                              ),
                                            ],
                                          ),
                                        ),
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: BlocBuilder<PlayerBloc, PlayerState>(
                                builder: (context, state) {
                                  if (state is PlayerLoading) {
                                    return CircularProgressIndicator(
                                        color: Color.yellow);
                                  }

                                  return buildButton(context);
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
      ),
    );
  }

  Widget buildPlayerInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(horizontal: 6),
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {},
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

  CCMaterialRedButton buildButton(BuildContext context) {
    final userId =
        (context.read<UserBloc>().state as UserAuthenticated).user.userId;

    return CCMaterialRedButton(
      text: "SUBMIT",
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();

        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          if (userId.isNotEmpty && widget.teamId.isNotEmpty) {
            if (widget.playerId != null) {
              context.read<PlayerBloc>().add(UpdatePlayer(
                  idPlayer: widget.playerId!,
                  idUser: userId,
                  idTim: widget.teamId,
                  playerName: playerNameCtrl.text,
                  tglLahir: tanggalLahirCtrl.text,
                  nisn: nisnCtrl.text,
                  posisi: posisiCtrl.text,
                  noPunggung: nomorPunggungCtrl.text,
                  foto: _fotoPlayer,
                  aktaLahir: _aktaPlayer,
                  kk: _kkPlayer));
            } else {
              context.read<PlayerBloc>().add(AddNewPlayer(
                  idUser: userId,
                  idTim: widget.teamId,
                  playerName: playerNameCtrl.text,
                  tglLahir: tanggalLahirCtrl.text,
                  nisn: nisnCtrl.text,
                  posisi: posisiCtrl.text,
                  noPunggung: nomorPunggungCtrl.text,
                  foto: _fotoPlayer,
                  aktaLahir: _aktaPlayer,
                  kk: _kkPlayer));
            }
          }
        }
      },
    );
  }
}
