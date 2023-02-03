import '../utilities/colors.dart';
import '../models/cabor.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';
import 'package:flutter/material.dart';

import '../models/team.dart';

class AddTeamScreen extends StatelessWidget {
  const AddTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cabor = ModalRoute.of(context)?.settings.arguments as Cabor;

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
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Color.purple,
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://th.bing.com/th/id/OIP.Y_6f7ZGEjjN9CDqfSQTRXQHaEK?pid=ImgDet&rs=1"),
                                            fit: BoxFit.cover),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          AddTeamList(
                                            title: "${cabor.namaCabor} (PA)",
                                            createNewPressed: () {
                                              Navigator.pushNamed(context, '/submit-team', arguments: TeamType.Man);
                                            },
                                            teams: dummyTeamPA,
                                          ),
                                          const SizedBox(height: 16),
                                          AddTeamList(
                                            title: "${cabor.namaCabor} (PI)",
                                            createNewPressed: () {
                                              Navigator.pushNamed(context, '/submit-team', arguments: TeamType.Woman);
                                            },
                                            teams: dummyTeamPI,
                                          ),
                                        ],
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
                                child: Image.asset(
                                    "assets/images/cc_logo_futsal.png",
                                    width: 80),
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

class AddTeamList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Color.red)),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          spacing: 6,
          runSpacing: 8,
          children: [
            ...teams.map(
              (team) {
                return TeamItem(
                  name: team.name,
                  logo: team.logo,
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-players', arguments: team);
                  },
                );
              },
            ),
            GestureDetector(
              onTap: createNewPressed,
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
                  Text("Tambah\nTim",
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
enum TeamType { Man, Woman }

class TeamItem extends StatelessWidget {
  const TeamItem({Key? key, required this.name, required this.logo, this.onPressed})
      : super(key: key);
  final String name;
  final Widget logo;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
          Text(name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith()),
        ],
      ),
    );
  }
}
