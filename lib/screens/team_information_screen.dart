import 'package:cyphercity/cubit/user_cubit.dart';
import 'package:cyphercity/utilities/colors.dart';
import 'package:cyphercity/utilities/config.dart';
import 'package:cyphercity/services/api_services.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class TeamInformationScreen extends StatelessWidget {
  const TeamInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiServices(http.Client());

    return Stack(
      children: [
        const BackgroundGradient(),
        SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: FutureBuilder(
                  future: apiService.getIDSekolah(
                      idUser: (context.read<UserCubit>().state as UserLoaded)
                          .user
                          .userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child:
                              CircularProgressIndicator(color: Color.yellow));
                    }

                    final data = snapshot.data?.data;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        const BrandLogo(width: 50, height: 50),
                        Text(
                          data?.namaSekolah ?? "",
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
                                          image: DecorationImage(
                                              image: NetworkImage((data !=
                                                          null &&
                                                      data.gambar.isNotEmpty)
                                                  ? data.gambar
                                                  : "https://via.placeholder.com/480x300"),
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
                                              data?.biodata ?? "-",
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                            ),
                                            const SizedBox(height: 16),
                                            FutureBuilder(
                                              future: apiService.getAllCabor(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: Color
                                                                  .yellow));
                                                }

                                                return Wrap(
                                                    spacing: 16,
                                                    runSpacing: 8,
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: snapshot
                                                            .data?.data
                                                            ?.map((cabor) =>
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
                                                        []);
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
                                  child: data != null && data.logo.isNotEmpty
                                      ? Image.network(data.logo, width: 80)
                                      : Icon(Icons.image_not_supported_outlined,
                                          color: Color.purple, size: 45),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
