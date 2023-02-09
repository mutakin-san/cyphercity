import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../core/repos/repositories.dart';
import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';
import '../widgets/cc_material_button.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

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
                        child: IconButton(
                          onPressed: () {
                            final userId = (context.read<UserBloc>().state
                                    as UserAuthenticated)
                                .user
                                .userId;
                            Navigator.pushNamed(context, '/profile',
                                arguments: userId);
                          },
                          color: Colors.white,
                          icon: const Icon(
                            Icons.account_circle_outlined,
                          ),
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
            FutureBuilder(
              future: RepositoryProvider.of<EventRepository>(context)
                  .getAllEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Color.yellow,
                  ));
                }

                final listEvent = snapshot.data?.data;

                return Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    itemCount: listEvent?.length ?? 0,
                    itemBuilder: (context, index) {
                      final event = listEvent?.elementAt(index);
                      return Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage(event != null &&
                                        event.gambar.isNotEmpty
                                    ? "https://sfc.webseitama.com/upload/event/${event.gambar}"
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(listEvent?.elementAt(index).namaEvent ?? "",
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
                                      Navigator.pushNamed(
                                          context, '/register-competition',
                                          arguments:
                                              listEvent?.elementAt(index));
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
              },
            ),
          ],
        ),
      ],
    );
  }
}
