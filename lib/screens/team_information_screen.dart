import 'package:cyphercity/consts/colors.dart';
import 'package:cyphercity/consts/config.dart';
import 'package:cyphercity/screens/add_team_screen.dart';
import 'package:cyphercity/services/api_services.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';

class TeamInformationScreen extends StatelessWidget {
  const TeamInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                                        Text(
                                          "Biodata Team : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(height: 1.5),
                                        ),
                                        Text(
                                          "Lorem ipsum dolor amet ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(height: 1.5),
                                        ),
                                        const SizedBox(height: 16),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/edit-biodata');
                                          },
                                          color: Colors.white,
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Text(
                                              "Edit Your Biodata Team"),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          "Achievement : ",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                        ),
                                        const SizedBox(height: 16),
                                        FutureBuilder(
                                          future: ApiServices.getAllCabor(),
                                          builder: (context, snapshot) {
                                            return Wrap(
                                                spacing: 16,
                                                runSpacing: 8,
                                                alignment: WrapAlignment.center,
                                                children: snapshot.data?.data
                                                        ?.map(
                                                            (cabor) =>
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/add-team',
                                                                        arguments:
                                                                            cabor);
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                          padding: const EdgeInsets.all(
                                                                              16),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child: Image.network(
                                                                              "$baseImageUrlCabor/${cabor.gambar}",
                                                                              width: 50)),
                                                                      const SizedBox(
                                                                          height:
                                                                              8),
                                                                      Text(
                                                                          cabor
                                                                              .namaCabor,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium
                                                                              ?.copyWith()),
                                                                    ],
                                                                  ),
                                                                ))
                                                        .toList() ??
                                                    []
                                                //   [

                                                //   Flexible(
                                                //     flex: 1,
                                                //     child: GestureDetector(
                                                //       onTap: () {
                                                //         Navigator.pushNamed(
                                                //             context, '/add-team',
                                                //             arguments: AddType
                                                //                 .Vollyball);
                                                //       },
                                                //       child: Column(
                                                //         children: [
                                                //           Container(
                                                //             padding:
                                                //                 const EdgeInsets
                                                //                     .all(16),
                                                //             decoration:
                                                //                 BoxDecoration(
                                                //               color: Colors.white,
                                                //               borderRadius:
                                                //                   BorderRadius
                                                //                       .circular(
                                                //                           10),
                                                //             ),
                                                //             child: const Icon(
                                                //                 Icons
                                                //                     .sports_volleyball,
                                                //                 size: 45),
                                                //           ),
                                                //           const SizedBox(
                                                //               height: 8),
                                                //           Text("Vollyball\nTeam",
                                                //               textAlign: TextAlign
                                                //                   .center,
                                                //               style: Theme.of(
                                                //                       context)
                                                //                   .textTheme
                                                //                   .bodyMedium
                                                //                   ?.copyWith()),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                //   Flexible(
                                                //     flex: 1,
                                                //     child: GestureDetector(
                                                //       onTap: () {
                                                //         Navigator.pushNamed(
                                                //             context, '/add-team',
                                                //             arguments: AddType
                                                //                 .Basketball);
                                                //       },
                                                //       child: Column(
                                                //         children: [
                                                //           Container(
                                                //             padding:
                                                //                 const EdgeInsets
                                                //                     .all(16),
                                                //             decoration:
                                                //                 BoxDecoration(
                                                //               color: Colors.white,
                                                //               borderRadius:
                                                //                   BorderRadius
                                                //                       .circular(
                                                //                           10),
                                                //             ),
                                                //             child: const Icon(
                                                //                 Icons
                                                //                     .sports_basketball,
                                                //                 size: 45),
                                                //           ),
                                                //           const SizedBox(
                                                //               height: 8),
                                                //           Text("Basketball\nTeam",
                                                //               textAlign: TextAlign
                                                //                   .center,
                                                //               style: Theme.of(
                                                //                       context)
                                                //                   .textTheme
                                                //                   .bodyMedium
                                                //                   ?.copyWith()),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ],
                                                );
                                          },
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
    );
  }
}
