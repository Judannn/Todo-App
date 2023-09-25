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
      title: const Text(
        'Add',
        style: TextStyle(color: Color(0xffff79c6)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Title"),
            TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xff44475a),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white))),
          ]),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Note"),
              TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Color(0xff44475a),
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.white))),
            ],
          ),
          const SizedBox(height: 10),
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
              Todo todo = Todo(
                name: titleController.text,
                description: descriptionController.text,
                dateCreated: DateTime.now().toIso8601String(),
              );
              Provider.of<TodoList>(context, listen: false).add(todo);
              // Cleanup
              Navigator.pop(context);
              descriptionController.clear();
              titleController.clear();
            })
      ],
    );
  }
}
