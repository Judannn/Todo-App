import 'package:flutter/material.dart';
import 'package:test_app/models/todo.dart';

class NoteCard extends StatelessWidget {
  final Todo todo;

  const NoteCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        ListTile(
          title: Text(todo.name),
          subtitle: Text(todo.description),
        )
      ],
    ));
  }
}
