import 'package:cyphercity/core/repos/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../models/school.dart';
import '../utilities/colors.dart';
import '../utilities/config.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';

class SchoolInformationScreen extends StatelessWidget {
  const SchoolInformationScreen({super.key});

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
                child: BlocSelector<SchoolBloc, SchoolState, School?>(
                  selector: (state) =>
                      state is SchoolLoaded ? state.data : null,
                  builder: (_, data) {
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
                                                  ? "$baseImageUrlTim/${data.gambar}"
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
                                              data != null &&
                                                      data.biodata.isNotEmpty
                                                  ? data.biodata
                                                  : "-",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(height: 1.5),
                                            ),
                                            const SizedBox(height: 16),
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/edit-biodata',
                                                    arguments: data?.id);
                                              },
                                              color: Colors.white,
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: const Text(
                                                  "Edit Biodata Sekolah"),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              "Daftar Tim : ",
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
                                              future: context
                                                  .read<CaborRepository>()
                                                  .getAllCabor(),
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
                                                                  onTap: data !=
                                                                          null
                                                                      ? () {
                                                                          Navigator.pushNamed(
                                                                              context,
                                                                              '/add-team',
                                                                              arguments: cabor);
                                                                        }
                                                                      : () {},
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsets.all(16),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: NetworkImage("$baseImageUrlCabor/${cabor.gambar}")),
                                                                          ),
                                                                        ),
                                                                      ),
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
                                      ? Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "$baseImageUrlLogo/${data.logo}"),
                                              fit: BoxFit.cover,
                                            ),
                                          ))
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
