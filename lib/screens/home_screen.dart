import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utilities/config.dart';
import '../bloc/bloc.dart';
import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import '../widgets/brand_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onCreateTeamClicked, this.onEventsClicked});

  final VoidCallback? onCreateTeamClicked;
  final VoidCallback? onEventsClicked;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    context.read<NewsBloc>().add(LoadNews());
    super.initState();
  }

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
                      onTap: widget.onEventsClicked,
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
                              child: const Icon(Icons.emoji_events, size: 35),
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
                            state.user.level != "0",
                        builder: (context, isSchoolAccess) {
                          return isSchoolAccess
                              ? GestureDetector(
                                  onTap: widget.onCreateTeamClicked,
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
                                              size: 35),
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
                              child: const Icon(Icons.info_outlined, size: 35),
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
                    Text("Hightlights",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    const SizedBox(height: 8),
                    BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
                      if (state is NewsLoading) {
                        return Center(
                            child:
                                CircularProgressIndicator(color: Color.yellow));
                      }

                      if (state is NewsLoaded && state.data.isNotEmpty) {
                        final data = state.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider.builder(
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
                                        image: CachedNetworkImageProvider(
                                            "$baseImageUrlNews/${news.gambar}"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 100,
                                  width: double.infinity,
                                );
                              },
                              options: CarouselOptions(viewportFraction: 0.9),
                            ),
                            const SizedBox(height: 24),
                            ...data.map((news) => Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  color: Color.redPurple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(8),
                                    title: Text(
                                      news.judul,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      news.deskripsi,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.white54),
                                    ),
                                    enabled: false,
                                    leading: Container(
                                      decoration: BoxDecoration(
                                          color: Color.redPurple,
                                          image: DecorationImage(
                                                  image: CachedNetworkImageProvider(
                                                "$baseImageUrlNews/${news.gambar}"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                )),
                          ],
                        );
                      }

                      if (state is NewsFailed) {
                        return Center(
                            child: Text(
                          state.error,
                          style: TextStyle(
                            color: Color.yellow,
                          ),
                        ));
                      }

                      return const SizedBox();
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
