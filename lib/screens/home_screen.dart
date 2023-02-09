import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyphercity/utilities/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../core/repos/repositories.dart';
import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, this.onCreateTeamClicked, this.onEventsClicked});

  final VoidCallback? onCreateTeamClicked;
  final VoidCallback? onEventsClicked;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserNotAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        }
      },
      child: Stack(
        children: [
          const BackgroundGradient(),
          ListView(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top,
                    bottom: 24,
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
                    const BrandLogo(width: 50, height: 50, isDark: true),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserAuthenticated) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Hi,\n${state.user.nama}",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/profile',
                                        arguments: state.user.userId);
                                  },
                                  color: Colors.white,
                                  icon: const Icon(
                                    Icons.account_circle_outlined,
                                  ),
                                ),
                              )
                            ],
                          );
                        }

                        return const SizedBox();
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onEventsClicked,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color.gray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.event, size: 45),
                            ),
                            const SizedBox(height: 8),
                            Text("Event",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    BlocSelector<UserBloc, UserState, bool>(
                        selector: (state) =>
                            state is UserAuthenticated &&
                            state.user.level == "1",
                        builder: (context, isSchoolAccess) {
                          return isSchoolAccess
                              ? GestureDetector(
                                  onTap: onCreateTeamClicked,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Color.gray,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                              Icons.group_add_rounded,
                                              size: 45),
                                        ),
                                        const SizedBox(height: 8),
                                        Text("Create Team",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/information');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color.gray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.info_outlined, size: 45),
                            ),
                            const SizedBox(height: 8),
                            Text("Information",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("News Update",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    const SizedBox(height: 8),
                    FutureBuilder(
                        future: RepositoryProvider.of<NewsRepository>(context)
                            .getAllNews(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: Color.yellow));
                          }

                          if (snapshot.hasData && snapshot.data?.data != null) {
                            final data = snapshot.data!.data!;
                            return CarouselSlider.builder(
                              carouselController: _controller,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                final news = data.elementAt(itemIndex);
                                return Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  decoration: BoxDecoration(
                                      color: Color.redPurple,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "$baseImageUrlNews/${news.gambar}"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 100,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      news.judul,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: Colors.white,
                                              shadows: [
                                            const Shadow(
                                                color: Colors.white54,
                                                blurRadius: 10)
                                          ]),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(viewportFraction: 0.9),
                            );
                          }

                          return Center(
                              child: Text(
                            "${snapshot.data?.message}",
                            style: TextStyle(
                              color: Color.yellow,
                            ),
                          ));
                        }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
