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
      decoration: FlutterLogoDecoration(style: FlutterLogoStyle.stacked, textColor: isDark ? Colors.black : Colors.white),
      width: width,
      height: height,
    );
  }
}
