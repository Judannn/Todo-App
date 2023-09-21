import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/todo.dart';

import '../models/todo_list.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key, required this.toDo});
  final Todo toDo;

  @override
  State<EditForm> createState() => _EditForm();
}

class _EditForm extends State<EditForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    titleController.text = widget.toDo.name;
    descriptionController.text = widget.toDo.description;

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
        ],
      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Delete'),
            onPressed: () {
              Provider.of<TodoList>(context, listen: false).delete(widget.toDo);
              descriptionController.clear();
              titleController.clear();
              Navigator.pop(context);
            }),
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
                  internalID: widget.toDo.key.toString(),
                  name: titleController.text,
                  description: descriptionController.text,
                  dateCreated: widget.toDo.dateCreated,
                  completed: widget.toDo.completed));
              descriptionController.clear();
              titleController.clear();
              Navigator.pop(context);
            }),
      ],
    );
  }
}
