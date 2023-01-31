import 'package:cyphercity/utilities/colors.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/cc_text_form_field.dart';
import 'package:flutter/material.dart';

import '../widgets/brand_logo.dart';
import '../widgets/cc_material_button.dart';

class FormAddTeamScreen extends StatelessWidget {
  FormAddTeamScreen({super.key});

  final TextEditingController teamNameCtrl = TextEditingController();
  final TextEditingController pembinaCtrl = TextEditingController();
  final TextEditingController pelatihCtrl = TextEditingController();
  final TextEditingController asistenPelatihCtrl = TextEditingController();
  final TextEditingController medisTeamCtrl = TextEditingController();
  final TextEditingController koordinatorSupporterCtrl = TextEditingController();

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
                      Text(
                        "SMPN 2 CIAMIS",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
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
                                  child: Form(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CCTextFormField(
                                            controller: teamNameCtrl,
                                            label: "Team Name",
                                            textColor: Colors.black),
                                        const SizedBox(height: 8),
                                        CCTextFormField(
                                            controller: pembinaCtrl,
                                            label: "Pembina/Manager",
                                            textColor: Colors.black),
                                        const SizedBox(height: 8),
                                        CCTextFormField(
                                            controller: pelatihCtrl,
                                            label: "Pelatih",
                                            textColor: Colors.black),
                                        const SizedBox(height: 8),
                                        CCTextFormField(
                                            controller: asistenPelatihCtrl,
                                            label: "Asisten Pelatih",
                                            textColor: Colors.black),
                                        const SizedBox(height: 8),
                                        CCTextFormField(
                                            controller: medisTeamCtrl,
                                            label: "Medis Team",
                                            textColor: Colors.black),
                                        const SizedBox(height: 8),
                                        CCTextFormField(
                                            controller: koordinatorSupporterCtrl,
                                            label: "Koordinator Supporter",
                                            textColor: Colors.black),
                                        const SizedBox(height: 8),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              const Icon(Icons.description_rounded),
                                              const Text("Surat Keterangan Kepala Sekolah"),
                                              Text(
                                                "Upload Disini",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    ?.copyWith(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Color.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Center(
                                          child: CCMaterialRedButton(
                                            text: "SUBMIT",
                                            onPressed: () {
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
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: Text(
                                  "Upload\nLogo Team",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Color.red),
                                ),
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
}
