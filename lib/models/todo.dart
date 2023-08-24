class Todo {
  final String id;
  final String name;
  final String description;
  final bool completed;

  Todo(
      {required this.name,
      required this.description,
      this.completed = false,
      this.id = ""});

  @override
  String toString() {
    // return name + " (" + description + ") "; old operation on string
    return "$name - ($description) "; //String interpolation
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'completed': completed ? 1 : 0,
    };
  }
}
