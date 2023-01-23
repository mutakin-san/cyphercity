import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyphercity/consts/colors.dart';
import 'package:cyphercity/widgets/background_gradient.dart';
import 'package:cyphercity/widgets/brand_logo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.onCreateTeamClicked});

  final VoidCallback onCreateTeamClicked;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      Text("Hi,\nSMPN : CIAMIS",
                          style: Theme.of(context).textTheme.titleMedium),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: () {},
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
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
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: onCreateTeamClicked,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color.gray,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                const Icon(Icons.group_add_rounded, size: 45),
                          ),
                          const SizedBox(height: 8),
                          Text("Create Team",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
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
                      child: Center(child: Text("Content $itemIndex")),
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
    );
  }
}
