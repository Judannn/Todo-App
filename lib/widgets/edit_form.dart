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
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.toDo.completed;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    titleController.text = widget.toDo.name;
    descriptionController.text = widget.toDo.description;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Edit'),
          Switch(
              trackColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (isCompleted) {
                  return Colors.green;
                }
                return null;
              }),
              value: isCompleted,
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                  (Set<MaterialState> states) {
                if (isCompleted) {
                  return const Icon(Icons.check_rounded);
                }
                return const Icon(Icons
                    .close_rounded); // All other states will use the default thumbIcon.
              }),
              onChanged: ((value) {
                setState(() {
                  isCompleted = value;
                });
              })),
        ],
      ),
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
              Map<String, dynamic> todoMap = {
                "id": widget.toDo.internalID,
                "key": widget.toDo.key.toString(),
                "name": widget.toDo.name,
                "description": widget.toDo.description,
                "dateCreated": DateTime.now().toIso8601String(),
                "completed": widget.toDo.completed,
              };
              Provider.of<TodoList>(context, listen: false).delete(todoMap);

              // Cleanup
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
              Map<String, dynamic> todoMap = {
                "id": widget.toDo.internalID,
                "key": widget.toDo.key.toString(),
                "name": titleController.text,
                "description": descriptionController.text,
                "dateCreated": DateTime.now().toIso8601String(),
                "completed": isCompleted,
              };
              Provider.of<TodoList>(context, listen: false).edit(todoMap);

              // Cleanup
              descriptionController.clear();
              titleController.clear();
              Navigator.pop(context);
            }),
      ],
    );
  }
}
