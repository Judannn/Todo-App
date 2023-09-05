import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/todo_list.dart';
import 'package:test_app/services/hive_datasource.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  bool completeSelected = false;
  bool incompleteSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterChip(
            selected: completeSelected,
            onSelected: (bool selected) {
              setState(() {
                completeSelected = selected;
                if (selected) {
                  incompleteSelected = false;
                  Provider.of<TodoList>(context, listen: false)
                      .browse(ListFilter.complete);
                } else {
                  Provider.of<TodoList>(context, listen: false)
                      .browse(ListFilter.all);
                }
              });
            },
            label: const Text('Complete')),
        const SizedBox(width: 10),
        FilterChip(
            selected: incompleteSelected,
            onSelected: (bool selected) {
              setState(() {
                incompleteSelected = selected;
                if (selected) {
                  completeSelected = false;
                  Provider.of<TodoList>(context, listen: false)
                      .browse(ListFilter.incomplete);
                } else {
                  Provider.of<TodoList>(context, listen: false)
                      .browse(ListFilter.all);
                }
              });
            },
            label: const Text('Incomplete')),
      ],
    );
  }
}
