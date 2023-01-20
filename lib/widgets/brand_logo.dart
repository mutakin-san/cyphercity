import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({
    Key? key, this.isDark = false, required this.width, required this.height,
  }) : super(key: key);

  final bool isDark;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/cc_logo.png"))
      ),
    );
  }
}
