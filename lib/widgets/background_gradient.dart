import '../utilities/colors.dart';
import 'package:flutter/widgets.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.redPurple, Color.redBlack, Color.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
