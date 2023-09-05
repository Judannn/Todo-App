import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterChip(
            onSelected: (bool selected) {}, label: const Text('Completed')),
        const SizedBox(width: 10),
        FilterChip(
            onSelected: (bool selected) {}, label: const Text('Incompleted')),
      ],
    );
  }
}
