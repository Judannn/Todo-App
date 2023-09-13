import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/todo.dart';

import '../models/todo_list.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key, required this.todo});
  final Todo todo;

  @override
  State<EditForm> createState() => _EditForm(todo.completed);
}

class _EditForm extends State<EditForm> {
  _EditForm(this.completed);

  bool completed;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    titleController.text = widget.todo.name;
    descriptionController.text = widget.todo.description;

    return AlertDialog(
      title: const Text('Edit To Do'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(children: [
            const Text("Title"),
            TextFormField(controller: titleController),
          ]),
          const SizedBox(height: 50),
          Column(
            children: [
              const Text("Note"),
              TextFormField(controller: descriptionController),
            ],
          ),
          const SizedBox(height: 50),
          SegmentedButton<bool>(
            segments: const <ButtonSegment<bool>>[
              ButtonSegment<bool>(value: true, label: Text('Complete')),
              ButtonSegment<bool>(value: false, label: Text('Incomplete')),
            ],
            selected: <bool>{completed},
            onSelectionChanged: (Set<bool> newSelection) {
              setState(() {
                // By default there is only a single segment that can be
                // selected at one time, so its value is always the first
                // item in the selected set.
                completed = newSelection.first;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Save'),
            onPressed: () {
              Provider.of<TodoList>(context, listen: false).edit(Todo(
                  name: titleController.text,
                  description: descriptionController.text,
                  dateCreated: widget.todo.dateCreated,
                  completed: completed));
              Navigator.pop(context);
              descriptionController.clear();
              titleController.clear();
            })
      ],
    );
  }
}
