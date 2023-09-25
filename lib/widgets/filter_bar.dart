import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/todo_list.dart';
import 'package:test_app/services/datasource.dart';

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
        //     Badge(
        // label: Text(Provider.of<TodoList>(context, listen: false)
        //     .completeTodo
        //     .toString()),
        // child:
        // 0xff79c6
        Badge(
          textColor: Colors.white,
          backgroundColor: const Color(0xff44475a),
          label: Text(Provider.of<TodoList>(context, listen: false)
              .completeTodo
              .toString()),
          child: FilterChip(
              labelStyle: TextStyle(
                color:
                    completeSelected ? const Color(0xff44475a) : Colors.white,
              ),
              showCheckmark: false,
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
        ),
        const SizedBox(width: 10),
        Badge(
          textColor: Colors.white,
          backgroundColor: const Color(0xff44475a),
          label: Text(Provider.of<TodoList>(context, listen: false)
              .incompleteTodo
              .toString()),
          child: FilterChip(
              labelStyle: TextStyle(
                color:
                    incompleteSelected ? const Color(0xff44475a) : Colors.white,
              ),
              showCheckmark: false,
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
              label: Text('Incomplete')),
        ),
      ],
    );
  }
}
