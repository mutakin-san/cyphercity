import 'package:cyphercity/utilities/colors.dart';
import 'package:flutter/material.dart';

import '../models/team.dart';
import '../widgets/cc_material_button.dart';

class AddTeamPlayersScreen extends StatelessWidget {
  const AddTeamPlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final team = ModalRoute.of(context)?.settings.arguments as Team;

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
                          const Text("Pemain Bola Voli"),
                          buildPlayerInput(context),
                          buildPlayerInput(context),
                          buildPlayerInput(context),
                          buildPlayerInput(context),
                          buildPlayerInput(context),
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
              IconButton(onPressed: (){
                Navigator.pop(context);
              },iconSize: 35, icon: const Icon(Icons.arrow_back))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlayerInput(BuildContext context) {
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
            onTap: () {
              Navigator.pushNamed(context, '/submit-player');
            },
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
