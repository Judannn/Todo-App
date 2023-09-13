import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/models/todo.dart';
import 'package:test_app/widgets/edit_form.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (builder) {
              return EditForm(
                todo: todo,
              );
            });
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: (MediaQuery.of(context).size.width / 2 - 23),
          height: 150,
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
              //                   <--- right side
              color: todo.completed ? Colors.green : Colors.grey,
              width: 5.0,
            ),
          )),
          padding:
              const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 0),
                child: Text(todo.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(todo.description,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                    DateFormat.yMMMEd()
                        .format(DateTime.parse(todo.dateCreated)),
                    style: Theme.of(context).textTheme.labelSmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
