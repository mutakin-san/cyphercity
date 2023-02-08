import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocSelector<UserBloc, UserState, String>(
                          selector: (state) =>
                              state is UserAuthenticated ? state.user.nama : "",
                          builder: (context, name) {
                            return Text("Hi,\n$name",
                                style: Theme.of(context).textTheme.titleLarge);
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black,
                          ),
                          child: IconButton(
                            onPressed: () {
                              context.read<UserBloc>().add(UserLogout());
                            },
                            color: Colors.white,
                            icon: const Icon(
                              Icons.account_circle_outlined,
                            ),
                          ),
                        )
                      ],
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
                    CarouselSlider.builder(
                      carouselController: _controller,
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                            color: Color.gray,
                            borderRadius: BorderRadius.circular(10)),
                        height: 100,
                        child: const Center(child: Text("Content ")),
                      ),
                      options: CarouselOptions(viewportFraction: 0.9),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Placeholder(
                  color: Color.yellow,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
