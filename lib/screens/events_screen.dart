import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utilities/config.dart';
import '../bloc/bloc.dart';
import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_material_button.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    try {
      final userId =
          (context.read<UserBloc>().state as UserAuthenticated).user.userId;
      context.read<EventBloc>().add(GetAllEvent(userId));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundGradient(),
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top,
                  bottom: 16,
                  left: 16,
                  right: 16),
              decoration: BoxDecoration(
                  color: Color.gray,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 24),
                  const BrandLogo(width: 50, height: 50, isDark: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserAuthenticated) {
                            return Text("Hi,\n${state.user.nama}",
                                style: Theme.of(context).textTheme.titleLarge);
                          }

                          return const SizedBox();
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: BlocSelector<UserBloc, UserState, String?>(
                          selector: (state) {
                            return state is UserAuthenticated
                                ? state.user.userId
                                : null;
                          },
                          builder: (context, userId) {
                            return IconButton(
                              onPressed: userId != null
                                  ? () {
                                      Navigator.pushNamed(context, '/profile',
                                          arguments: userId);
                                    }
                                  : null,
                              color: Colors.white,
                              icon: const Icon(
                                Icons.account_circle_outlined,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Register for Competition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Color.red),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            BlocSelector<UserBloc, UserState, String?>(
              selector: (state) {
                return state is UserAuthenticated ? state.user.userId : null;
              },
              builder: (context, userId) {
                return userId != null
                    ? BlocBuilder<EventBloc, EventState>(
                        builder: (context, state) {
                          if (state is EventLoading) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: Color.yellow,
                            ));
                          }

                          if (state is EventLoaded) {
                            final listEvent = state.events;

                            if (listEvent.isNotEmpty) {
                              return Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 16),
                                  itemCount: listEvent.length,
                                  itemBuilder: (context, index) {
                                    final event = listEvent.elementAt(index);
                                    return Container(
                                      height: 150,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(event
                                                      .gambar.isNotEmpty
                                                  ? "$baseImageUrlEvent/${event.gambar}"
                                                  : "https://via.placeholder.com/480x300"),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(0, 3),
                                                color: Colors.black54,
                                                blurRadius: 10)
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              listEvent
                                                  .elementAt(index)
                                                  .namaEvent,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      shadows: const [
                                                    Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 8,
                                                        offset: Offset(0.0, 2)),
                                                    Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 8,
                                                        offset: Offset(0.0, 3))
                                                  ])),
                                          BlocBuilder<SchoolBloc, SchoolState>(
                                            builder: (context, state) {
                                              if (state is SchoolLoaded) {
                                                return CCMaterialRedButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        '/register-competition',
                                                        arguments: listEvent
                                                            .elementAt(index));
                                                  },
                                                  text: "REG",
                                                );
                                              }

                                              return const SizedBox();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
                                      context
                                          .read<EventBloc>()
                                          .add(GetAllEvent(userId));
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
                                context
                                    .read<EventBloc>()
                                    .add(GetAllEvent(userId));
                              },
                              icon: const Icon(Icons.refresh,
                                  color: Colors.white),
                              label: const Text('Refresh',
                                  style: TextStyle(color: Colors.white)));
                        },
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }
}
