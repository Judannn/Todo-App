class Todo {
  final String id;
  final String name;
  final String description;
  final String dateCreated;
  final bool completed;

  Todo({
    this.id = "",
    required this.name,
    required this.description,
    this.completed = false,
    required this.dateCreated,
  });

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
      'dateCreated': dateCreated,
      'completed': completed ? 1 : 0,
    };
  }
}
