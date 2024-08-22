import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final void Function(DateTime) onDateSelected;

  const CustomDatePicker(
      {super.key, required this.initialDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null) {
          onDateSelected(picked);
          (context as Element).markNeedsBuild();
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(),
        child: Text(
          style: const TextStyle(fontSize: 16, color: Colors.white),
          initialDate != null
              ? DateFormat('yyyy-MM-dd').format(initialDate!)
              : 'Select a date',
        ),
      ),
    );
  }
}
