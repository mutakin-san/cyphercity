
import 'package:flutter/material.dart';

class CCTextFormField extends StatelessWidget {

  const CCTextFormField({
    Key? key,
    required this.controller,
    this.label,
    this.hintText,
    this.textInputAction,
    this.isObsecure = false,
    this.icon,
    this.validator,
    this.textColor = Colors.white,
    this.maxLines
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final Color textColor;
  final TextInputAction? textInputAction;
  final bool isObsecure;
  final Icon? icon;
  final String? Function(String?)? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        label != null
            ? Text(
                "$label",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: textColor),
              )
            : const SizedBox(),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: isObsecure,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: validator,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8)),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: icon,
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          ),
        ),
      ],
    );
  }
}
