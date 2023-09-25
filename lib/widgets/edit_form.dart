import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/todo.dart';

import '../models/todo_list.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key, required this.todo});
  final Todo todo;

  @override
  State<EditForm> createState() => _EditForm();
}

class _EditForm extends State<EditForm> {
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.todo.completed;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    titleController.text = widget.todo.name;
    descriptionController.text = widget.todo.description;

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Edit',
            style: TextStyle(color: Color(0xffff79c6)),
          ),
          Switch(
              trackOutlineColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (isCompleted) {
                  return Colors.transparent;
                }
                return Colors.transparent;
              }),
              thumbColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (isCompleted) {
                  return const Color(0xff44475a);
                }
                return const Color(0xff44475a);
              }),
              trackColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (isCompleted) {
                  return const Color(0xff50fa7b);
                }
                return null;
              }),
              value: isCompleted,
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                  (Set<MaterialState> states) {
                if (isCompleted) {
                  return const Icon(
                    Icons.check_rounded,
                    color: Color(0xff50fa7b),
                  );
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Title"),
            TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Color(0xff44475a),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(color: Colors.white),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Delete'),
                onPressed: () async {
                  BuildContext dialogContext = context;
                  await showDialog(
                      context: dialogContext,
                      builder: (builder) {
                        return AlertDialog(
                          title: const Text(
                            'Delete todo?',
                            style: TextStyle(color: Color(0xffff5555)),
                          ),
                          actions: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      // Cleanup
                                      Navigator.pop(dialogContext);
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () async {
                                      Provider.of<TodoList>(dialogContext,
                                              listen: false)
                                          .delete(widget.todo);
                                      // Cleanup
                                      Navigator.pop(dialogContext);
                                    },
                                    child: const Text('Yes')),
                              ],
                            )
                          ],
                        );
                      });
                  // Cleanup
                  descriptionController.clear();
                  titleController.clear();
                  Navigator.pop(context);
                }),
            Row(
              children: [
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
                      Todo todo = Todo(
                          id: widget.todo.id,
                          name: titleController.text,
                          description: descriptionController.text,
                          dateCreated: DateTime.now().toIso8601String(),
                          completed: isCompleted);
                      Provider.of<TodoList>(context, listen: false).edit(todo);

                      // Cleanup
                      descriptionController.clear();
                      titleController.clear();
                      Navigator.pop(context);
                    }),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
