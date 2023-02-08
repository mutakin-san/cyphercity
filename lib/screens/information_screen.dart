import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import '../widgets/background_gradient.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          ListView(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top,
                    bottom: 48,
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
                    const Icon(
                      Icons.info,
                      size: 45,
                    ),
                    Text(
                      "Informasi",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height * 0.2,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
              child: Image.asset("assets/images/cc_logo.png", height: 60),
            ),
          )
        ],
      ),
    );
  }
}
