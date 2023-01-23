
import 'package:cyphercity/consts/colors.dart';
import 'package:flutter/material.dart';

class CCMaterialRedButton extends StatelessWidget {
  const CCMaterialRedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Color.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        minWidth: 150,
        height: 45,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(text));
  }
}
