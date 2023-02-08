import 'package:flutter/material.dart';

class CCDropdownFormField<T> extends StatelessWidget {
  const CCDropdownFormField(
      {super.key,
      required this.label,
      this.labelColor = Colors.white,
      required this.items,
      required this.selectedValue,
      required this.onChanged,
      this.validator});

  final String label;
  final Color? labelColor;
  final List<DropdownMenuItem<T>> items;
  final T selectedValue;
  final String? Function(T?)? validator;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: labelColor)),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
            items: items,
            isDense: true,
            isExpanded: true,
            validator: validator,
            style: const TextStyle(color: Colors.black87),
            value: selectedValue,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white),
            onChanged: onChanged),
      ],
    );
  }
}
