import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import '../core/repos/repositories.dart';
import '../utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/bloc.dart';
import '../utilities/colors.dart';
import '../utilities/helper.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_dropdown_form_field.dart';
import '../widgets/cc_material_button.dart';
import '../widgets/cc_text_form_field.dart';

class EditSchoolBiodataScreen extends StatefulWidget {
  const EditSchoolBiodataScreen({super.key, this.kode});

  final String? kode;

  @override
  State<EditSchoolBiodataScreen> createState() =>
      _EditSchoolBiodataScreenState();
}

class _EditSchoolBiodataScreenState extends State<EditSchoolBiodataScreen> {
  final TextEditingController schoolNameCtrl = TextEditingController();

  final TextEditingController npsnCtrl = TextEditingController();

  final TextEditingController biodataTimCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  XFile? _schoolimage;
  XFile? _logoImage;
  String? _selectedRegion;

  Future<void> getSchoolImage() async {
    final source = await chooseImageSource(context);
    if (source != null) {
      await pickImage(
        source: source,
        onChoosed: (image) {
          if (image != null) {
            setState(() {
              _schoolimage = image;
            });
          }
        },
      );
    }
  }

  Future<void> getLogoImage(
      String? kode, String userId, BuildContext context) async {
    final schoolBloc = context.read<SchoolBloc>();
    final source = await chooseImageSource(context);
    if (source != null) {
      await pickImage(
        source: source,
        onChoosed: (image) {
          if (image != null) {
            if (kode != null && userId.isNotEmpty) {
              schoolBloc.add(EditSchoolLogo(kode, userId, image));
            }
            setState(() {
              _logoImage = image;
            });
          }
        },
      );
    }
  }

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      const BrandLogo(width: 50, height: 50),
                      BlocSelector<SchoolBloc, SchoolState, String>(
                        selector: (state) =>
                            state is SchoolLoaded ? state.data.namaSekolah : "",
                        builder: (context, schoolName) {
                          return Text(
                            schoolName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.white),
                          );
                        },
                      ),
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
                                  child: BlocBuilder<SchoolBloc, SchoolState>(
                                    builder: (context, state) {
                                      if (state is SchoolLoaded) {
                                        schoolNameCtrl.text =
                                            state.data.namaSekolah;
                                        npsnCtrl.text = state.data.npsn;
                                        biodataTimCtrl.text =
                                            state.data.biodata;
                                        _selectedRegion =
                                            state.data.idRegion == "0"
                                                ? null
                                                : state.data.idRegion;
                                      }
                                      return Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CCTextFormField(
                                              controller: schoolNameCtrl,
                                              label: "Nama Sekolah/Tim",
                                              textColor: Colors.black,
                                              validator: ValidationBuilder()
                                                  .required()
                                                  .build(),
                                            ),
                                            const SizedBox(height: 8),
                                            CCTextFormField(
                                              controller: npsnCtrl,
                                              label: "NPSN",
                                              textColor: Colors.black,
                                              inputType: TextInputType.number,
                                              validator: ValidationBuilder()
                                                  .required()
                                                  .build(),
                                            ),
                                            const SizedBox(height: 8),
                                            FutureBuilder(
                                                future: RepositoryProvider.of<
                                                            RegionRepository>(
                                                        context)
                                                    .getAllRegional(),
                                                builder: (_, snapshot) {
                                                  return CCDropdownFormField(
                                                      label: 'Regional',
                                                      hint: snapshot.connectionState ==
                                                              ConnectionState
                                                                  .waiting
                                                          ? "Loading..."
                                                          : "Pilih Region",
                                                      labelColor: Colors.black,
                                                      items: (snapshot.hasData &&
                                                              snapshot.data
                                                                      ?.data !=
                                                                  null)
                                                          ? snapshot.data!.data!
                                                              .map((region) => DropdownMenuItem<
                                                                      String>(
                                                                  value: region
                                                                      .idRegion,
                                                                  child: Text(
                                                                      region.nama)))
                                                              .toList()
                                                          : <DropdownMenuItem<String>>[],
                                                      selectedValue: _selectedRegion,
                                                      validator: (value) {
                                                        return value != null &&
                                                                value.isNotEmpty
                                                            ? null
                                                            : "Region Required";
                                                      },
                                                      onChanged: (value) {
                                                        _selectedRegion = value;

                                                        if (kDebugMode) {
                                                          print(
                                                              _selectedRegion);
                                                        }
                                                      });
                                                }),
                                            const SizedBox(height: 8),
                                            CCTextFormField(
                                                controller: biodataTimCtrl,
                                                label: "Biodata Sekolah/Tim",
                                                textColor: Colors.black,
                                                validator: ValidationBuilder()
                                                    .required()
                                                    .build(),
                                                maxLines: 6),
                                            const SizedBox(height: 8),
                                            Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 24,
                                                      horizontal: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                              ),
                                              child: _schoolimage != null
                                                  ? Stack(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: FileImage(File(
                                                                      _schoolimage!
                                                                          .path)),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: IconButton(
                                                              color:
                                                                  Colors.white,
                                                              onPressed: () {
                                                                setState(() {
                                                                  _schoolimage =
                                                                      null;
                                                                });
                                                              },
                                                              icon: const Icon(Icons
                                                                  .close_rounded)),
                                                        ),
                                                      ],
                                                    )
                                                  : GestureDetector(
                                                      onTap: getSchoolImage,
                                                      child: Column(
                                                        children: [
                                                          const Icon(Icons
                                                              .image_outlined),
                                                          const Text(
                                                              "Foto Tim Sekolah"),
                                                          Text(
                                                            "Upload Disini",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall
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
                                            BlocConsumer<SchoolBloc,
                                                SchoolState>(
                                              builder: (context, state) {
                                                if (state is SchoolLoading) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: Color
                                                                  .yellow));
                                                } else {
                                                  return buildButton(
                                                      context, widget.kode);
                                                }
                                              },
                                              listener: (context, state) {
                                                if (state is SchoolFailed) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              state.message)));
                                                }

                                                if (state is SchoolLoaded) {
                                                  const duration =
                                                      Duration(seconds: 1);
                                                  if (_logoImage != null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Logo Berhasil Di Update"),
                                                                duration:
                                                                    duration));
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Data Sekolah Berhasil Di Update"),
                                                                duration:
                                                                    duration));
                                                  }
                                                }
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
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
                                child: _logoImage != null
                                    ? BlocBuilder<SchoolBloc, SchoolState>(
                                        builder: (context, state) {
                                          if (state is SchoolLoading) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Color.yellow));
                                          }

                                          if (state is SchoolLoaded) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: FileImage(File(
                                                              _logoImage!
                                                                  .path)),
                                                          fit: BoxFit.cover)),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  bottom: 0,
                                                  left: 0,
                                                  child: IconButton(
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          _logoImage = null;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.close_rounded)),
                                                ),
                                              ],
                                            );
                                          }

                                          return Icon(
                                              Icons
                                                  .image_not_supported_outlined,
                                              color: Color.purple,
                                              size: 45);
                                        },
                                      )
                                    : BlocSelector<UserBloc, UserState, String>(
                                        selector: (state) {
                                        return state is UserAuthenticated
                                            ? state.user.userId
                                            : "";
                                      }, builder: (context, userId) {
                                        return BlocSelector<SchoolBloc,
                                            SchoolState, String>(
                                          selector: (state) {
                                            return state is SchoolLoaded
                                                ? state.data.logo
                                                : "";
                                          },
                                          builder: (context, logo) {
                                            if (logo.isNotEmpty) {
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          "$baseImageUrlLogo/$logo"),
                                                      fit: BoxFit.cover),
                                                ),
                                                child: IconButton(
                                                    color: Color.yellow,
                                                    onPressed: () =>
                                                        getLogoImage(
                                                            widget.kode,
                                                            userId,
                                                            context),
                                                    icon: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration:
                                                          const BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black45,
                                                              blurRadius: 10,
                                                              spreadRadius: 4)
                                                        ],
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                          Icons.edit),
                                                    )),
                                              );
                                            } else {
                                              return GestureDetector(
                                                onTap: () => getLogoImage(
                                                    widget.kode,
                                                    userId,
                                                    context),
                                                child: Text(
                                                  "Upload\nLogo Team",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          color: Color.red),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      }),
                              ),
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
    );
  }

  Widget buildButton(BuildContext context, String? kode) {
    return Center(
      child: BlocSelector<UserBloc, UserState, String?>(
        selector: (state) {
          return state is UserAuthenticated ? state.user.userId : null;
        },
        builder: (context, userId) {
          return CCMaterialRedButton(
            text: "SUBMIT",
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                if (userId != null && _selectedRegion != null) {
                  context.read<SchoolBloc>().add(EditSchoolBiodata(
                      kode: kode,
                      idUser: userId,
                      idRegion: _selectedRegion!,
                      namaSekolah: schoolNameCtrl.text,
                      npsn: npsnCtrl.text,
                      biodata: biodataTimCtrl.text,
                      image: _schoolimage));
                }
              }
            },
          );
        },
      ),
    );
  }
}
