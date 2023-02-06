import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({
    Key? key, this.isDark = false, required this.width, required this.height, this.logoUrl
  }) : super(key: key);

  final bool isDark;
  final double width;
  final double height;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: (logoUrl != null) ? BoxShape.circle : BoxShape.rectangle,
        image: (logoUrl != null && logoUrl!.isNotEmpty) ? DecorationImage(image: NetworkImage("$logoUrl"), fit: BoxFit.cover) : const DecorationImage(image: AssetImage("assets/images/cc_logo.png"))
      ),
    );
  }
}
