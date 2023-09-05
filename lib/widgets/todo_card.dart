import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/models/todo_list.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width / 2 - 23),
            // height: 300,
            padding:
                const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 0, left: 20, right: 20, bottom: 0),
                  child: Text(todo.name,
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(todo.description,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(todo.dateCreated,
                      style: Theme.of(context).textTheme.labelSmall),
                ),
              ],
            ),
          ),
          Positioned(
            top: -40,
            left: 0,
            child: GestureDetector(
              onTap: () {
                todo.completed = true;
                Provider.of<TodoList>(context, listen: false).edit(todo);
                print("Container clicked");
              },
              child: Container(
                transform: Matrix4.rotationZ(0.7853981633974483),
                width: 50,
                height: 50,
                color: todo.completed ? Colors.green : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
