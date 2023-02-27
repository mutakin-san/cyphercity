import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';
import 'package:flutter_html/flutter_html.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key, this.isShowBackButton = true});

  final bool isShowBackButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          BlocBuilder<AboutBloc, AboutState>(
            builder: (context, state) {
              if (state is AboutLoading) {
                return Center(
                    child: CircularProgressIndicator(color: Color.yellow));
              }

              if (state is AboutFailed) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(state.error),
                      TextButton.icon(
                          onPressed: () async {
                            context.read<AboutBloc>().add(LoadAbout());

                            await Future.delayed(const Duration(seconds: 1));
                          },
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text('Refresh',
                              style: TextStyle(color: Colors.white)))
                    ],
                  ),
                );
              }
              if (state is AboutLoaded) {
                final title = state.about["judul"];
                final description = state.about["deskripsi"];
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 45, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Color.gray,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 45,
                                child: Image.asset("assets/images/cc_logo.png",
                                    height: 60),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                title ?? "About Us",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: isShowBackButton,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                iconSize: 35,
                                icon: const Icon(Icons.arrow_back)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Html(
                              data: description,
                              style: {
                                "body": Style(
                                  color: Colors.white,
                                  lineHeight: LineHeight.rem(1.5),
                                  textAlign: TextAlign.justify,
                                ),
                              },
                            )
                            // Text(
                            //   description ?? "-",
                            //   textAlign: TextAlign.justify,
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .bodyMedium
                            //       ?.copyWith(color: Colors.white),
                            // ),
                            ),
                      ),
                    )
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
