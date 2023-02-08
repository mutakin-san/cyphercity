import 'dart:io';

import '../screens/add_team_screen.dart';
import '../widgets/cc_dropdown_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/bloc.dart';
import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_material_button.dart';
import '../widgets/cc_text_form_field.dart';

class FormAddTeamScreen extends StatefulWidget {
  const FormAddTeamScreen({super.key, required this.caborId});

  final String caborId;

  @override
  State<FormAddTeamScreen> createState() => _FormAddTeamScreenState();
}

class _FormAddTeamScreenState extends State<FormAddTeamScreen> {
  final TextEditingController teamNameCtrl = TextEditingController();

  final TextEditingController pembinaCtrl = TextEditingController();

  final TextEditingController pelatihCtrl = TextEditingController();

  final TextEditingController asistenPelatihCtrl = TextEditingController();

  final TextEditingController medisTeamCtrl = TextEditingController();

  final TextEditingController koordinatorSupporterCtrl =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String teamType = TeamType.PA.name;

  late String userId;
  late String schoolId;

  @override
  void initState() {
    userId = (context.read<UserBloc>().state as UserAuthenticated).user.userId;
    schoolId = (context.read<SchoolBloc>().state as SchoolLoaded).data.id;
    super.initState();
  }

  XFile? _skkpImage;

  Future<void> getSkkpImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _skkpImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimBloc, TimState>(
      listener: (context, state) {
        if (state is TimCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Tim berhasil dibuat!")));

          // context.read<TimBloc>().add(LoadTim(userId, schoolId, widget.caborId));

          Future.delayed(const Duration(seconds: 2))
              .then((value) => Navigator.pop(context));
        }

        if (state is TimFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        const BrandLogo(width: 50, height: 50),
                        BlocSelector<UserBloc, UserState, String>(
                            selector: (state) => state is UserAuthenticated
                                ? state.user.nama
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 60.0, left: 16, right: 16),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CCTextFormField(
                                              controller: teamNameCtrl,
                                              label: "Team Name",
                                              validator: ValidationBuilder()
                                                  .required()
                                                  .build(),
                                              textColor: Colors.black),
                                          const SizedBox(height: 8),
                                          CCDropdownFormField(label: 'Tipe Team', labelColor: Colors.black, items: TeamType.values.map((e) => DropdownMenuItem(value: e.name,child: Text(e.name))).toList(), selectedValue: teamType, onChanged: (value) {
                                            setState(() {
                                              teamType = value!;
                                            });
                                          },),
                                          const SizedBox(height: 8),
                                          CCTextFormField(
                                              controller: pembinaCtrl,
                                              label: "Pembina/Manager",
                                              validator: ValidationBuilder()
                                                  .required()
                                                  .build(),
                                              textColor: Colors.black),
                                          const SizedBox(height: 8),
                                          CCTextFormField(
                                              controller: pelatihCtrl,
                                              label: "Pelatih",
                                              validator: ValidationBuilder()
                                                  .required()
                                                  .build(),
                                              textColor: Colors.black),
                                          const SizedBox(height: 8),
                                          CCTextFormField(
                                              controller: asistenPelatihCtrl,
                                              label: "Asisten Pelatih",
                                              validator: ValidationBuilder()
                                                  .required()
                                                  .build(),
                                              textColor: Colors.black),
                                          const SizedBox(height: 8),
                                          CCTextFormField(
                                              controller: medisTeamCtrl,
                                              label: "Medis Team",
                                              validator: ValidationBuilder()
                                                  .required()
                                                  .build(),
                                              textColor: Colors.black),
                                          const SizedBox(height: 8),
                                          CCTextFormField(
                                              controller:
                                                  koordinatorSupporterCtrl,
                                              label: "Koordinator Supporter",
                                              validator: ValidationBuilder()
                                                  .required()
                                                  .build(),
                                              textColor: Colors.black),
                                          const SizedBox(height: 8),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 24),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white,
                                            ),
                                            child: (_skkpImage != null)
                                                ? Stack(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: FileImage(
                                                                    File(_skkpImage!
                                                                        .path)),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                      Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: IconButton(
                                                            color: Colors.white,
                                                            onPressed: () {
                                                              setState(() {
                                                                _skkpImage =
                                                                    null;
                                                              });
                                                            },
                                                            icon: const Icon(Icons
                                                                .close_rounded)),
                                                      ),
                                                    ],
                                                  )
                                                : GestureDetector(
                                                    onTap: getSkkpImage,
                                                    child: Column(
                                                      children: [
                                                        const Icon(Icons
                                                            .description_rounded),
                                                        const Text(
                                                            "Surat Keterangan Kepala Sekolah"),
                                                        Text(
                                                          "Upload Disini",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .caption
                                                              ?.copyWith(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                  color: Color
                                                                      .red),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                          const SizedBox(height: 16),
                                          Center(
                                            child:
                                                BlocBuilder<TimBloc, TimState>(
                                              builder: (context, state) {
                                                if (state is TimLoading) {
                                                  return CircularProgressIndicator(
                                                      color: Color.yellow);
                                                }

                                                return buildButton(
                                                    context, widget.caborId, teamType);
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   top: 0,
                              //   left: 0,
                              //   right: 0,
                              //   child: CircleAvatar(
                              //     radius: 60,
                              //     backgroundColor: Colors.white,
                              //     child: Text(
                              //       "Upload\nLogo Team",
                              //       textAlign: TextAlign.center,
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .bodyMedium
                              //           ?.copyWith(color: Color.red),
                              //     ),
                              //   ),
                              // )
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

  CCMaterialRedButton buildButton(
      BuildContext context, String idCabor, String teamType) {
    return CCMaterialRedButton(
      text: "SUBMIT",
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();

        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          if (_skkpImage == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Silahkan upload SKKP terlebih dahulu!")));
          }

          if (userId.isNotEmpty &&
              schoolId.isNotEmpty &&
              idCabor.isNotEmpty &&
              teamType.isNotEmpty &&
              _skkpImage != null) {
            context.read<TimBloc>().add(
                  AddNewTeam(
                      idUser: userId,
                      idSchool: schoolId,
                      idCabor: idCabor,
                      namaTeam: teamNameCtrl.text,
                      pembina: pembinaCtrl.text,
                      pelatih: pelatihCtrl.text,
                      asistenPelatih: asistenPelatihCtrl.text,
                      teamMedis: medisTeamCtrl.text,
                      kordinatorSupporter: koordinatorSupporterCtrl.text,
                      teamType: teamType,
                      skkpImage: _skkpImage!),
                );
          }
        }
      },
    );
  }
}
