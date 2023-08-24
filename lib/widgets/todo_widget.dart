import 'package:flutter/material.dart';
import 'package:test_app/models/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(todo.name),
                Text(todo.description),
              ],
            )));
  }
}
