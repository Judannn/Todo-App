import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/todo.dart';

import '../models/todo_list.dart';

class AddForm extends StatelessWidget {
  const AddForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return AlertDialog(
      title: const Text('Add To Do'),
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
          )
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
            child: const Text('Add'),
            onPressed: () {
              Provider.of<TodoList>(context, listen: false).add(Todo(
                  name: titleController.text,
                  description: descriptionController.text,
                  dateCreated: DateTime.now().toIso8601String()));
              Navigator.pop(context);
              descriptionController.clear();
              titleController.clear();
            })
      ],
    );
  }
}
