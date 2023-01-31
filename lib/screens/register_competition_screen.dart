import 'package:cyphercity/utilities/colors.dart';
import 'package:cyphercity/widgets/cc_dropdown_form_field.dart';
import 'package:cyphercity/widgets/cc_material_button.dart';
import 'package:flutter/material.dart';

class RegisterCompetitionScreen extends StatefulWidget {
  const RegisterCompetitionScreen({super.key});

  @override
  State<RegisterCompetitionScreen> createState() =>
      _RegisterCompetitionScreenState();
}

class _RegisterCompetitionScreenState extends State<RegisterCompetitionScreen> {
  int _numberOfTeam = 1;

  List<Widget> buildTeamSelection(int numberOfTeam) {
    return List.generate(numberOfTeam, (index) {
      String selectedTeam = "Team 1";
      return CCDropdownFormField<String>(
        items: ["Team 1", "Team 2", "Team 3", "Team 4", "Team 5", "Team 6"]
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        selectedValue: selectedTeam,
        onChanged: (value) {
          setState(() {
            selectedTeam = value ?? selectedTeam;
          });
        },
        label: "Select Team",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.gray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        child: Image.asset(
                          'assets/images/cc_logo_futsal.png',
                          height: 45,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "REGISTRASI SFC VOLLEYBALL",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Form(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            CCDropdownFormField<int>(
                              items: [1, 2, 3, 4, 5, 6]
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text("$e"),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _numberOfTeam = value ?? _numberOfTeam;
                                });
                              },
                              label: "Number of Teams",
                              selectedValue: _numberOfTeam,
                            ),
                            ...buildTeamSelection(_numberOfTeam),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                    "If you haven't created a team yet, "),
                                GestureDetector(
                                  onTap: () {},
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
                                child: CCMaterialRedButton(
                                    onPressed: () {}, text: "REG")),
                          ],
                        ),
                      ))
                    ],
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      iconSize: 35,
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
