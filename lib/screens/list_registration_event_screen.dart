import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyphercity/models/reg_event.dart';
import 'package:cyphercity/utilities/colors.dart';
import 'package:cyphercity/utilities/helper.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc.dart';
import '../core/repos/repositories.dart';

class ListRegistrationEventScreen extends StatefulWidget {
  const ListRegistrationEventScreen({super.key});

  @override
  State<ListRegistrationEventScreen> createState() =>
      _ListRegistrationEventScreenState();
}

class _ListRegistrationEventScreenState
    extends State<ListRegistrationEventScreen> {
  XFile? buktiBayar;
  late final eventBloc =
      EventBloc(RepositoryProvider.of<EventRepository>(context));

  void updateImageState(XFile? image, setState) {
    setState(() {
      buktiBayar = image;
    });
  }

  Future confirmPayment(BuildContext context, RegEvent item) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            actions: [
              BlocConsumer<EventBloc, EventState>(
                bloc: eventBloc,
                listener: (context, state) {
                  if (state is ConfirmPaymentSucces) {
                    eventBloc.add(GetRegisteredEvent(
                        userId: item.idUser, schoolId: item.idSekolah));

                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is EventLoading) {
                    return Center(
                        child: CircularProgressIndicator(color: Color.yellow));
                  }
                  return ElevatedButton.icon(
                    onPressed: () {
                      if (buktiBayar != null) {
                        eventBloc.add(
                          ConfirmPaymentEvent(
                            idReg: item.idReg,
                            idEvent: item.idEvent,
                            idUser: item.idUser,
                            idSekolah: item.idSekolah,
                            idCabor: item.idCabor,
                            idTim: item.idTim,
                            buktiBayar: buktiBayar!,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text("Simpan"),
                  );
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear),
                label: const Text("Cancel"),
              ),
            ],
            title: const Text(
              "Upload Bukti Pembayaran",
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  StatefulBuilder(builder: (context, setState) {
                    return GestureDetector(
                      onTap: () async {
                        final source = await chooseImageSource(context);
                        if (source != null) {
                          await pickImage(
                              source: source,
                              onChoosed: (image) {
                                if (image != null) {
                                  updateImageState(image, setState);
                                }
                              });
                        }
                      },
                      child: buktiBayar != null
                          ? Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Color.redPurple,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: FileImage(
                                          File(buktiBayar!.path),
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  child: IconButton(
                                    color: Color.yellow,
                                    onPressed: () {
                                      updateImageState(null, setState);
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                )
                              ],
                            )
                          : Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color.redPurple,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.file_upload_outlined,
                                color: Colors.white,
                              ),
                            ),
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    try {
      final school = (context.read<SchoolBloc>().state as SchoolLoaded).data;
      final userId = school.idUser;
      final schoolId = school.id;
      eventBloc.add(GetRegisteredEvent(userId: userId, schoolId: schoolId));
      // ignore: empty_catches
    } catch (e) {}
    super.initState();
  }

  @override
  void dispose() {
    eventBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.redPurple,
        title: const Text("Daftar Registrasi Event"),
        elevation: 0,
      ),
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<SchoolBloc, SchoolState>(
                  builder: (context, state) {
                    if (state is SchoolLoaded) {
                      final userId = state.data.idUser;
                      final schoolId = state.data.id;
                      return BlocBuilder<EventBloc, EventState>(
                        bloc: eventBloc,
                        builder: (_, state) {
                          if (state is EventLoading) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Color.yellow,
                            ));
                          }

                          if (state is RegisteredEventLoaded) {
                            final listRegEvent = state.data;

                            if (listRegEvent.isNotEmpty) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  border:
                                      TableBorder.all(color: Color.redPurple),
                                  dataTextStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white),
                                  headingTextStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: Color.redBlack,
                                          fontWeight: FontWeight.bold),
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Color.yellow),
                                  columns: const [
                                    DataColumn(
                                        label: Text("ID"), numeric: true),
                                    DataColumn(label: Text("Event")),
                                    DataColumn(label: Text("Tim")),
                                    DataColumn(
                                        label: Text("Tanggal Registrasi")),
                                    DataColumn(label: Text("Jam Registrasi")),
                                    DataColumn(label: Text("Status")),
                                    DataColumn(label: Text("Aksi")),
                                  ],
                                  rows: listRegEvent
                                      .map((item) => DataRow(cells: [
                                            DataCell(Text(item.idReg)),
                                            DataCell(Text(item.namaEvent)),
                                            DataCell(Text(item.namaTeam)),
                                            DataCell(
                                              Text(DateFormat.yMMMEd()
                                                  .format(item.tglReg)),
                                            ),
                                            DataCell(Text(item.jamReg)),
                                            DataCell(
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: item.status == "0"
                                                        ? Color.red
                                                        : Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(item.status == "0"
                                                    ? "Belum Bayar"
                                                    : "Sudah Bayar"),
                                              ),
                                            ),
                                            DataCell(
                                              item.status == "0"
                                                  ? ElevatedButton(
                                                      onPressed: () async {
                                                        confirmPayment(
                                                            context, item);
                                                      },
                                                      child: const Text(
                                                          "Upload Bukti Bayar"),
                                                    )
                                                  : Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: const Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                            )
                                          ]))
                                      .toList(),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Column(
                                children: [
                                  CachedNetworkImage(
                                      imageUrl:
                                          "https://img.icons8.com/office/80/null/empty-box.png",
                                      width: 80,
                                      height: 80),
                                  Text(
                                    "Data Kosong!!!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Color.gray),
                                  )
                                ],
                              ));
                            }
                          }

                          if (state is EventFailed) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(state.error),
                                  TextButton.icon(
                                    onPressed: () {
                                      eventBloc.add(GetRegisteredEvent(
                                          userId: userId, schoolId: schoolId));
                                    },
                                    icon: const Icon(Icons.refresh,
                                        color: Colors.white),
                                    label: const Text('Refresh',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          }

                          return TextButton.icon(
                              onPressed: () {
                                eventBloc.add(GetRegisteredEvent(
                                    userId: userId, schoolId: schoolId));
                              },
                              icon: const Icon(Icons.refresh,
                                  color: Colors.white),
                              label: const Text('Refresh',
                                  style: TextStyle(color: Colors.white)));
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
