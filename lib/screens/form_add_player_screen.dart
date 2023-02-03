import '../utilities/colors.dart';
import '../widgets/cc_text_form_field.dart';
import 'package:flutter/material.dart';

import '../widgets/cc_material_button.dart';

class FormAddPlayerScreen extends StatelessWidget {
  FormAddPlayerScreen({super.key});

  final TextEditingController playerNameCtrl = TextEditingController();
  final TextEditingController tanggalLahirCtrl = TextEditingController();
  final TextEditingController nisnCtrl = TextEditingController();
  final TextEditingController posisiCtrl = TextEditingController();
  final TextEditingController nomorPunggungCtrl= TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final team = ModalRoute.of(context)?.settings.arguments as Team;

    return Scaffold(
      backgroundColor: Color.gray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text("ISFA NURJAMAN",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          CCTextFormField(
                              controller: playerNameCtrl,
                              label: "Nama Pemain",
                              textColor: Colors.black,
                              textInputAction: TextInputAction.next),
                          const SizedBox(height: 8),
                          CCTextFormField(
                              controller: tanggalLahirCtrl,
                              label: "Tanggal Lahir",
                              textColor: Colors.black,
                              textInputAction: TextInputAction.next),
                          const SizedBox(height: 8),
                          CCTextFormField(
                              controller: nisnCtrl,
                              label: "NISN",
                              textColor: Colors.black,
                              textInputAction: TextInputAction.next),
                          const SizedBox(height: 8),
                          CCTextFormField(
                              controller: posisiCtrl,
                              label: "Posisi",
                              textColor: Colors.black,
                              textInputAction: TextInputAction.next),
                          const SizedBox(height: 8),
                          CCTextFormField(
                              controller: nomorPunggungCtrl,
                              label: "Nomor Punggung",
                              textColor: Colors.black,
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
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                const Icon(Icons.description_rounded),
                                const Text("Foto"),
                                Text(
                                  "Upload Disini",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          fontStyle: FontStyle.italic,
                                          color: Color.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                           Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                const Icon(Icons.description_rounded),
                                const Text("Akta Kelahiran"),
                                Text(
                                  "Upload Disini",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(
                                          fontStyle: FontStyle.italic,
                                          color: Color.red),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: CCMaterialRedButton(
                              text: "SUBMIT",
                              onPressed: () {},
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
}
