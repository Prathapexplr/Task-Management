import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final String labelText;
  final void Function(String?)? onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: labelText),
      items: items,
      onChanged: onChanged,
    );
  }
}
